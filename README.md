
---

<h1 id="grafana">Grafana</h1>
<p>OpenSource Observability Platform.<br>
Grafana allows to query, visualize, and understand your metrics. Supports several data-sources.  Contains several rich dashboard widgets, graphs, histograms. Also allows easy integration with alerting mechanisms like Slack, Pagerduty etc.</p>
<h2 id="build-image">Build Image</h2>
<pre><code>$ git clone https://github.com/jrpamid/grafana.git
$ cd grafana
$ docker build --build-arg alpine_ver=latest \
             --build-arg grafana_ver=6.7.2 \
             --tag grafana:6.7.2_alpine \
             -f build/Dockerfile_alpine .
             
$ docker build --build-arg ubuntu_ver=18.04 \
             --build-arg grafana_ver=6.7.2 \
             --tag grafana:6.7.2_ubuntu \
             -f build/Dockerfile_ubuntu .
           
$ docker build --build-arg centos_ver=8 \
             --build-arg grafana_ver=6.7.2 \
             --tag grafana:6.7.2_centos \
             -f build/Dockerfile_centos .        
</code></pre>
<h2 id="details">Details</h2>
<blockquote>
<p>grafana_home = /opt/grafana<br>
grafana_data = /grafana/data<br>
grafana_plugins = /grafana/data/plugins<br>
grafana config file = /opt/grafana/conf/grafana.ini<br>
default login = admin/k33p!ts3cr3t</p>
</blockquote>
<h2 id="start-grafana---ephermal">Start Grafana - Ephermal</h2>
<blockquote>
<p>Note: data is lost once the container is deleted</p>
</blockquote>
<pre><code>$ docker run -itd --name=grafana1  \
                       -p 3000:3000  \
                       --rm jrpamid/grafana:6.7.2_alpine
</code></pre>
<h2 id="start-grafana---persistent">Start Grafana - Persistent</h2>
<pre><code>$ docker volume create grafana_data
$ docker run -itd --name=grafana2 \
         -p 3000:3000 \
         -v grafana_data:/grafana/data \
         jrpamid/grafana:6.7.2_alpine
</code></pre>

