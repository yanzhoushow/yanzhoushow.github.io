### kafka vs aws kinesis
- messaging system
- kafka
  - general-purpose pub/sub messaging system
  - overview
    - Topic
      - A topic is designed to store data streams in ordered and partitioned immutable sequence of records. 
    - Partition
      - Each topic is divided into multiple partitions and each broker stores one or more of those partitions. 
    - Producer
      - Applications send data streams to a partition via Producers
    - Consumer
      - data streasm an then be consumed and processed by other applications via Consumers - e.g., to get insights on data through analytics applications.
      - Multiple producers and consumers can publish and retrieve messages at the same time.

### which API type to build
- WebSocket API 
  - using persistent connections for real-time use cases
  - use cases
    - chat applications
    - dashboard
- REST API
  - tranditional request and response
  - public or private(only available in VPC) ?
- HTTP API
  - low-latency and cost-effective REST APIs with built-in features 
  - use cases
    - Open ID Connect
    - OAuth2
    - native CORS support
