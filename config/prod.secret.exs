# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :smartbet, Smartbet.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

ssl_key_path = System.get_env("SSL_KEY_PATH") || raise "environment variable SSL_KEY_PATH is missing."
ssl_cert_path = System.get_env("SSL_CERT_PATH") || raise "environment variable SSL_CERT_PATH is missing."
ssl_cacert_path = System.get_env("SSL_CACERT_PATH") || raise "environment variable SSL_CACERT_PATH is missing."

config :smartbet, SmartbetWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  force_ssl: [hsts: true],
  https: [
    port: 443,
    cipher_suite: :strong,
    otp_app: :mini_bazar,
    keyfile: ssl_key_path,
    certfile: ssl_cert_path,
    cacertfile: ssl_cacert_path,
    versions: [:"tlsv1.2"],
    ciphers: ~w(
      ECDHE-ECDSA-AES128-GCM-SHA256
      ECDHE-ECDSA-AES256-GCM-SHA384
      ECDHE-ECDSA-AES128-SHA
      ECDHE-ECDSA-AES256-SHA
      ECDHE-ECDSA-AES128-SHA256
      ECDHE-ECDSA-AES256-SHA384
      ECDHE-RSA-AES128-GCM-SHA256
      ECDHE-RSA-AES256-GCM-SHA384
      ECDHE-RSA-AES128-SHA
      ECDHE-RSA-AES256-SHA
      ECDHE-RSA-AES128-SHA256
      ECDHE-RSA-AES256-SHA384
      DHE-RSA-AES128-GCM-SHA256
      DHE-RSA-AES256-GCM-SHA384
      DHE-RSA-AES128-SHA
      DHE-RSA-AES256-SHA
      DHE-RSA-AES128-SHA256
      DHE-RSA-AES256-SHA256
    )c,
    honor_cipher_order: true,
    client_renegotiation: false,
    eccs: [
      :sect571r1, :sect571k1, :secp521r1, :brainpoolP512r1, :sect409k1,
      :sect409r1, :brainpoolP384r1, :secp384r1, :sect283k1, :sect283r1,
      :brainpoolP256r1, :secp256k1, :secp256r1, :sect239k1, :sect233k1,
      :sect233r1, :secp224k1, :secp224r1
    ],
  ]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :smartbet, SmartbetWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
