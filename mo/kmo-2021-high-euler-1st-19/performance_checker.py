import time
import psutil
import os

class PerformanceChecker:
    def __init__(self):
        self._t = None
        self.process_time = 0

    def start(self):
        self._t = time.perf_counter()
    
    def stop(self):
        end = time.perf_counter()
        self.process_time = round((end - self._t) * 1000)
        

    def print(self):
        print("=== PERFORMANCE ===")
        p = psutil.Process()
        rss = p.memory_info().rss / 2 ** 20 # MB
        
        print(f"Time: {self.process_time} ms")
        print(f"Memory: {round(rss, 3)} MB")