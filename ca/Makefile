all: kube-controller-manager-key.pem kube-controller-manager.pem
all: worker-certificates
all: ca
all: admin-key.pem admin.pem
all: kube-proxy-key.pem kube-proxy.pem
all: kube-scheduler-key.pem kube-scheduler.pem

admin-key.pem admin.pem: ca.pem ca-key.pem admin-csr.json
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		admin-csr.json | cfssljson -bare admin
# workaround because of multiple outputs
admin-key.pem: admin.pem

ca: ca.pem ca-key.pem

ca.pem ca-key.pem: ca-csr.json
	cfssl gencert -initca ca-csr.json | cfssljson -bare ca
# workaround because of multiple outputs
ca-key.pem: ca.pem

worker-certificates: worker-0-key.pem worker-0.pem worker-1-key.pem worker-1.pem worker-2-key.pem worker-2.pem

worker-%-key.pem worker-%.pem: ca.pem ca-key.pem ca-config.json worker-%-csr.json
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-hostname=worker-$* \
		-profile=kubernetes \
		worker-$*-csr.json | cfssljson -bare worker-$*
# TODO: additional -hostname=worker-$*,$(IPs) \
worker-%-key.pem: worker-%.pem

kube-controller-manager-key.pem kube-controller-manager.pem: ca.pem ca-key.pem ca-config.json kube-controller-manager-csr.json
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
kube-controller-manager-key.pem: kube-controller-manager.pem

kube-proxy-key.pem kube-proxy.pem: ca.pem ca-key.pem ca-config.json kube-proxy-csr.json
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-proxy-csr.json | cfssljson -bare kube-proxy
kube-proxy-key.pem: kube-proxy.pem

kube-scheduler-key.pem kube-scheduler.pem: ca.pem ca-key.pem ca-config.json kube-scheduler-csr.json
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=ca-config.json \
		-profile=kubernetes \
		kube-scheduler-csr.json | cfssljson -bare kube-scheduler

# continue: https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md#the-kubernetes-api-server-certificate

clean:
	rm -f *.pem *.csr
