FROM nginx:1.7.10
EXPOSE 80
ENV HHVM_VERSION 3.6.0~wheezy
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian wheezy main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
  supervisor hhvm=$HHVM_VERSION
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD default.conf /etc/nginx/conf.d/default.conf
CMD supervisord -e debug
