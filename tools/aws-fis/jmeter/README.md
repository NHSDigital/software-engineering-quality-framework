The files here are merely intended as an example. 

They have been adapted from the GitHub repo here:

https://github.com/kubernauts/jmeter-kubernetes

and this Medium article:

https://blog.kubernauts.io/load-testing-as-a-service-with-jmeter-on-kubernetes-fc5288bb0c8b

They assume that jMeter 5.0 has been deployed to a kubernetes namespace matching
the config in the Jenkinsfile, in this case appx-jmeter.

The JMX file was generated using jMeter UI on a Macbook. If you are experimenting and want to use this file as basis, the key sections to change are:

HTTP request config:
```
<stringProp name="HTTPSampler.domain">www.example.com</stringProp>
<stringProp name="HTTPSampler.port"></stringProp>
<stringProp name="HTTPSampler.protocol">https</stringProp>
<stringProp name="HTTPSampler.contentEncoding"></stringProp>
<stringProp name="HTTPSampler.path">/</stringProp>
<stringProp name="HTTPSampler.method">GET</stringProp>
```
No of threads = users:
```
<stringProp name="ThreadGroup.num_threads">50</stringProp>
```
Test duration in seconds:
```
<stringProp name="ThreadGroup.duration">360</stringProp>
```

Remove the backend listener section if you haven't deployed influxdb to record jMeter metrics. 

Contact the Texas team if you would like further details, as a full working
example of jMeter is beyond the scope of this AWS FIS example.
