# Домашнее задание к занятию «Kubernetes. Часть 1»  - `Растегаев И.О.`

---


### Задание 1

Использовал Docker.
Результа выполнения команды kubectl get po -n kube-system.

![get_pods](images/get_pods.jpg)


---


### Задание 2


Запуск Deployment и Service.
Скриншот с взаимодействием и конфиг Deployment.

![deployment_service.jpg](images/deployment_service.jpg)

[Конфиг Deployment](ex2/redis-deployment.yaml)


---

### Задание 3


ps aux внутри контейнера с redis.

```
rast@VM1:~/minikube$ kubectl exec -it redis-54457d549d-rcg6h -- ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
1001           1  0.0  0.0 128600  1108 ?        Ssl  11:34   0:02 redis-server 0.0.0.0:6379
1001          51  0.0  0.1   7644  2552 pts/0    Rs+  12:11   0:00 ps aux

```

Вывод логов контейнера за последние 5 минут.

```

rast@VM1:~/minikube$ kubectl logs -f redis-54457d549d-rcg6h --since=5m 
1:M 29 Mar 2025 12:17:08.908 * 1 changes in 900 seconds. Saving...
1:M 29 Mar 2025 12:17:08.909 * Background saving started by pid 69
69:C 29 Mar 2025 12:17:08.912 * DB saved on disk
69:C 29 Mar 2025 12:17:08.914 * RDB: 0 MB of memory used by copy-on-write
1:M 29 Mar 2025 12:17:09.010 * Background saving terminated with success

```

Удаление пода.

```

rast@VM1:~/minikube$ kubectl delete pod redis-54457d549d-rcg6h
pod "redis-54457d549d-rcg6h" deleted

```
Проброс порта в контейнер и подключение.

```
rast@VM1:~/minikube$ kubectl port-forward redis-54457d549d-mz7sm 6379:6379
Forwarding from 127.0.0.1:6379 -> 6379
Forwarding from [::1]:6379 -> 6379
Handling connection for 6379
Handling connection for 6379


```


---

### Задание 4


Ingress, направляющий запросы по префиксу /test.

```
rast@VM1:~/minikube$ curl http://192.168.49.2/test
Hello from k8s

```

[Конфиг Deployment](ex4/nginx-configmap-deployment.yaml)
