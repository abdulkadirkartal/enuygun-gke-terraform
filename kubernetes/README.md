# Kubernetes Bileşenleri Kurulum Kılavuzu

## 1. Monitoring Stack Kurulumu (Prometheus & Grafana)

```bash
# Namespace oluştur
kubectl create namespace monitoring

# Prometheus Operator ve Grafana kurulumu
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -f monitoring/prometheus-values.yaml -n monitoring
```

## 2. KEDA Kurulumu

```bash
# KEDA namespace oluştur
kubectl create namespace keda

# KEDA Operator kurulumu
kubectl apply -f keda/keda-install.yaml
```

## 3. Istio Kurulumu

```bash
# Istio namespace oluştur
kubectl create namespace istio-system

# Istio Operator kurulumu
kubectl apply -f istio/istio-operator.yaml

# Gateway ve VirtualService kurulumu
kubectl apply -f istio/gateway.yaml
```

## 4. Uygulama Deployment

```bash
# Uygulamayı deploy et
kubectl apply -f application-pool.yaml
```

## Doğrulama Adımları

1. Prometheus & Grafana:
   ```bash
   kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring
   ```
   - Tarayıcıda: http://localhost:3000
   - Kullanıcı adı: admin
   - Şifre: port-forward & admin

2. KEDA:
   ```bash
   kubectl get scaledobjects
   ```

3. Istio:
   ```bash
   kubectl get pods -n istio-system
   kubectl get gateway
   kubectl get virtualservice
   ```

## Monitoring

- Grafana'da "Pod Monitoring" dashboard'unu görüntüleyebilirsiniz
- Pod restart alarmları otomatik olarak yapılandırılmıştır 