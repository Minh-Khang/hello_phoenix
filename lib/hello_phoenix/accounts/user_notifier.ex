defmodule HelloPhoenix.Accounts.UserNotifier do
  @moduledoc false
  import Swoosh.Email
  require Logger
  alias HelloPhoenix.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"HelloPhoenix", "simon@jocamey.com"})
      |> subject(subject)
      |> text_body(body)

    Logger.info("Delivering email to #{recipient}")
    Logger.info("Subject: #{subject}")
    Logger.info("Body: #{body}")

    case Mailer.deliver(email) do
      {:ok, _metadata} -> {:ok, email}
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Reset password instructions", """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to magic_link login.
  """
  def deliver_magic_link_instructions(user, url) do
    deliver(user.email, "Login with Magic Link", """

    ==============================

    Hi #{user.email},

    You can log in by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
