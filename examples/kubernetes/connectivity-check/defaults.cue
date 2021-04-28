package connectivity_check

// Default parameters for echo clients (may be overridden).
deployment: [ID=_]: {
	// General pod parameters
	if ID =~ "^pod-to-.*$" || ID =~ "^host-to-.*$" {
		_image: "quay.io/cilium/alpine-curl:v1.2.0@sha256:bf2f87bb761821bf57b792d45edfd3a46cf5cca4c57da3fa3fc2abcb13b89dd3"
		_command: ["/bin/ash", "-c", "sleep 1000000000"]
	}

	// readinessProbe target name
	if ID =~ "^pod-to-a.*$" || ID =~ "^host-to-a.*$" {
		_probeTarget: *"echo-a:8080" | string
	}
	if ID =~ "^pod-to-b.*$" || ID =~ "^host-to-b.*$" {
		_probeTarget: *"echo-b:8080" | string
	}
	if ID =~ "^pod-to-c.*$" || ID =~ "^host-to-c.*$" {
		_probeTarget: *"echo-c:8080" | string
	}
}

// Default parameters for echo clients (final).
deployment: [ID=_]: {
	// Topology
	if ID =~ "^.*intra-node.*$" {
		metadata: labels: topology: "intra-node"
	}
	if ID =~ "^.*multi-node.*$" {
		metadata: labels: topology: "multi-node"
	}

	// Affinity
	if ID =~ "^.*to-a-intra-node-.*$" {
		_affinity: "echo-a"
	}
	if ID =~ "^.*to-a-multi-node-.*$" {
		_antiAffinity: "echo-a"
	}
	if ID =~ "^.*to-b-intra-node-.*$" {
		_affinity: "echo-b"
	}
	if ID =~ "^.*to-b-multi-node-.*$" {
		_antiAffinity: "echo-b"
	}
	if ID =~ "^.*to-c-intra-node-.*$" {
		_affinity: "echo-c"
	}
	if ID =~ "^.*to-c-multi-node-.*$" {
		_antiAffinity: "echo-c"
	}
}

// Default parameters for policies.
egressCNP: [ID=_]: {
	// Topology
	if ID =~ "^.*intra-node.*$" {
		metadata: labels: topology: "intra-node"
	}
	if ID =~ "^.*multi-node.*$" {
		metadata: labels: topology: "multi-node"
	}
}
