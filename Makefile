PROJECT = rabbitmq_lvc_exchange
PROJECT_DESCRIPTION = RabbitMQ Last Value Cache exchange

RABBITMQ_VERSION ?= v4.2.x
current_rmq_ref = $(RABBITMQ_VERSION)

define PROJECT_APP_EXTRA_KEYS
	{broker_version_requirements, ["4.2.0"]}
endef

ERLANG_MK_TMP ?= $(CURDIR)/.erlang.mk
RABBITMQ_REPO = https://github.com/rabbitmq/rabbitmq-server.git
RMQ_MONOREPO = $(ERLANG_MK_TMP)/rabbitmq-server

ifneq ($(filter distclean%,$(MAKECMDGOALS)),)
SKIP_DEPS = 1
endif

ifeq ($(filter distclean% clean%,$(MAKECMDGOALS)),)
ifeq ($(wildcard $(RMQ_MONOREPO)),)
$(info Cloning RabbitMQ server repository...)
$(shell git clone --depth 1 --branch $(RABBITMQ_VERSION) $(RABBITMQ_REPO) $(RMQ_MONOREPO) >&2)
endif
DEPS_DIR = $(RMQ_MONOREPO)/deps
endif

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
