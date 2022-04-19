FROM public.ecr.aws/lambda/ruby:2.7

# Update SO
RUN yum group install -y "Development Tools"

# Requiered by DB
RUN yum install -y libaio libaio-devel

# Install posgresql
RUN yum install -y postgresql postgresql-devel

# Install Oracle
COPY oracle.rpm ${LAMBDA_TASK_ROOT}
COPY devel.rpm ${LAMBDA_TASK_ROOT}
RUN yum install -y oracle.rpm devel.rpm
RUN export PATH=/usr/lib/oracle/21/client64/bin:$PATH

# Update bundler
RUN gem update bundler

# Copy function code
COPY app.rb ${LAMBDA_TASK_ROOT}

# Copy dependency management file
COPY Gemfile ${LAMBDA_TASK_ROOT}

# Install dependencies under LAMBDA_TASK_ROOT
ENV GEM_HOME=${LAMBDA_TASK_ROOT}
RUN bundle install

# You can overwrite command in `serverless.yml` template
CMD ["app.lambda_handler"]
