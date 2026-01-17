PROJECT = rabbitmq_lvc_exchange
PROJECT_DESCRIPTION = RabbitMQ Last Value Cache exchange

RABBITMQ_VERSION ?= v4.2.x
current_rmq_ref = $(RABBITMQ_VERSION)

define PROJECT_APP_EXTRA_KEYS
	{broker_version_requirements, ["4.2.0"]}
endef

RABBITMQ_REPO = https://github.com/rabbitmq/rabbitmq-server.git

dep_amqp_client                = git-subfolder $(RABBITMQ_REPO) $(RABBITMQ_VERSION) deps/amqp_client
dep_rabbit_common              = git-subfolder $(RABBITMQ_REPO) $(RABBITMQ_VERSION) deps/rabbit_common
dep_rabbit                     = git-subfolder $(RABBITMQ_REPO) $(RABBITMQ_VERSION) deps/rabbit
dep_rabbitmq_ct_client_helpers = git-subfolder $(RABBITMQ_REPO) $(RABBITMQ_VERSION) deps/rabbitmq_ct_client_helpers
dep_rabbitmq_ct_helpers        = git-subfolder $(RABBITMQ_REPO) $(RABBITMQ_VERSION) deps/rabbitmq_ct_helpers

DEPS = rabbit_common rabbit khepri khepri_mnesia_migration
TEST_DEPS = rabbitmq_ct_helpers rabbitmq_ct_client_helpers amqp_client

DEP_EARLY_PLUGINS = rabbit_common/mk/rabbitmq-early-plugin.mk
DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk

# FIXME: Use erlang.mk patched for RabbitMQ, while waiting for PRs to be
# reviewed and merged.

ERLANG_MK_REPO = https://github.com/rabbitmq/erlang.mk.git
ERLANG_MK_COMMIT = rabbitmq-tmp

include rabbitmq-components.mk
include erlang.mk
