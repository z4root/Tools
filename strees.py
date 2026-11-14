# import multiprocessing as mp
# import os
# import re
# import subprocess
# import time
#
# DURATION = 360
# WORKERS = min(8, os.cpu_count() or 1)
# SAMPLE_INTERVAL = 5
# STOP_TEMP = 90.0
#
#
# def cpu_work(start_event, deadline):
#     start_event.wait()
#
#     value = 1
#     while time.monotonic() < deadline:
#         value = (value * 1664525 + 1013904223) & 0xFFFFFFFF
#
#
# def read_sensors():
#     result = subprocess.run(["sensors"], capture_output=True, text=True, timeout=5)
#     output = result.stdout
#
#     patterns = {
#         "CPU Package": r"Package id 0:\s*\+?([\d.]+)°C",
#         "CPU fan": r"cpu_fan:\s*(\d+)\s*RPM",
#         "GPU fan": r"gpu_fan:\s*(\d+)\s*RPM",
#     }
#
#     values = {}
#     for name, pattern in patterns.items():
#         match = re.search(pattern, output)
#         values[name] = match.group(1) if match else "N/D"
#
#     return values
#
#
# if __name__ == "__main__":
#     context = mp.get_context("fork")
#     start_event = context.Event()
#     # deadline = time.monotonic() + DURATION
#     processes = []
#
#     print(f"Carga CPU: {WORKERS} procesos durante {DURATION} segundos")
#     print("No se modifica ninguna configuración.")
#     print("-" * 55)
#
#     try:
#         for _ in range(WORKERS):
#             process = context.Process(target=cpu_work, args=(deadline,))
#             process.start()
#             processes.append(process)
#
#         for sample in range(13):
#             values = read_sensors()
#             print(
#                 f"{sample * 5:02d}s | "
#                 f"CPU: {values['CPU Package']} °C | "
#                 f"Ventilador CPU: {values['CPU fan']} RPM | "
#                 f"Ventilador GPU: {values['GPU fan']} RPM",
#                 flush=True,
#             )
#
#             if sample < 12:
#                 time.sleep(5)
#
#     except KeyboardInterrupt:
#         print("\nPrueba interrumpida por el usuario.")
#
#     finally:
#         for process in processes:
#             if process.is_alive():
#                 process.terminate()
#         for process in processes:
#             process.join()
#
#     print("-" * 55)
#     print("Prueba finalizada. Los procesos de carga han terminado.")
#


import multiprocessing as mp
import os
import re
import subprocess
import time

DURATION = 300
WORKERS = min(8, os.cpu_count() or 1)
SAMPLE_INTERVAL = 5
STOP_TEMP = 90.0


def cpu_work(start_event, duration):
    start_event.wait()
    deadline = time.monotonic() + duration
    value = 1

    while time.monotonic() < deadline:
        value = (value * 1664525 + 1013904223) & 0xFFFFFFFF


def read_sensors():
    result = subprocess.run(["sensors"], capture_output=True, text=True, timeout=5)

    patterns = {
        "CPU Package": r"Package id 0:\s*\+?([\d.]+)°C",
        "CPU fan": r"cpu_fan:\s*(\d+)\s*RPM",
        "GPU fan": r"gpu_fan:\s*(\d+)\s*RPM",
    }

    values = {}

    for name, pattern in patterns.items():
        match = re.search(pattern, result.stdout)
        values[name] = float(match.group(1)) if match else None

    return values


if __name__ == "__main__":
    context = mp.get_context("fork")
    start_event = context.Event()
    processes = []
    reason = "Duración de la prueba completada"

    print("===== PRUEBA TERMICA ASUS =====")
    print(f"Duración: {DURATION} segundos")
    print(f"Procesos de CPU: {WORKERS}")
    print(f"Medición cada: {SAMPLE_INTERVAL} segundos")
    print(f"Umbral preventivo: {STOP_TEMP} °C")
    print("-" * 65)

    start_time = time.monotonic()
    deadline = start_time + DURATION

    try:
        for _ in range(WORKERS):
            process = context.Process(target=cpu_work, args=(start_event, DURATION))
            process.start()
            processes.append(process)

        start_time = time.monotonic()
        deadline = start_time + DURATION
        start_event.set()

        while True:
            elapsed = int(time.monotonic() - start_time)
            values = read_sensors()

            cpu = values["CPU Package"]
            cpu_fan = values["CPU fan"]
            gpu_fan = values["GPU fan"]

            cpu_text = f"{cpu:.1f} °C" if cpu is not None else "N/D"
            cpu_fan_text = f"{cpu_fan:.0f} RPM" if cpu_fan is not None else "N/D"
            gpu_fan_text = f"{gpu_fan:.0f} RPM" if gpu_fan is not None else "N/D"

            print(
                f"{elapsed:03d}s | CPU: {cpu_text} | "
                f"Ventilador CPU: {cpu_fan_text} | "
                f"Ventilador GPU: {gpu_fan_text}",
                flush=True,
            )

            if cpu is not None and cpu >= STOP_TEMP:
                reason = f"Detenida: CPU Package alcanzó {STOP_TEMP} °C"
                break

            if time.monotonic() >= deadline:
                break

            time.sleep(min(SAMPLE_INTERVAL, max(0, deadline - time.monotonic())))

    except KeyboardInterrupt:
        reason = "Interrumpida manualmente"

    finally:
        for process in processes:
            if process.is_alive():
                process.terminate()

        for process in processes:
            process.join()

    print("-" * 65)
    print(reason)
    print("Todos los procesos de carga han terminado.")
