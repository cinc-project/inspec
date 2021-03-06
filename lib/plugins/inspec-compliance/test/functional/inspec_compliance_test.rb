require_relative "../../../shared/core_plugin_test_helper"

class ComplianceCli < Minitest::Test
  include CorePluginFunctionalHelper

  def test_help_output
    out = run_inspec_process("compliance help")

    assert_includes out.stdout, "inspec compliance exec PROFILE"

    assert_exit_code 0, out
  end

  def test_logout_command
    out = run_inspec_process("compliance logout")

    assert_includes out.stdout, ""

    assert_exit_code 0, out
  end

  def test_error_login_with_invalid_url
    out = run_inspec_process("compliance login")

    assert_includes out.stderr, 'ERROR: "inspec compliance login" was called with no arguments'

    assert_exit_code 1, out
  end

  def test_profile_list_without_auth
    out = run_inspec_process("compliance profiles")

    assert_includes out.stdout, "You need to login first with `inspec compliance login`"

    assert_exit_code 0, out # TODO: make this error
  end

  def test_error_upload_without_args
    out = run_inspec_process("compliance upload")

    assert_includes out.stderr, 'ERROR: "inspec compliance upload" was called with no arguments'

    assert_exit_code 1, out
  end

  def test_error_upload_with_fake_path
    out = run_inspec_process("compliance upload /path/to/dir")

    assert_includes out.stdout, "You need to login first with `inspec compliance login`"

    assert_exit_code 0, out # TODO: make this error
  end

  ## testing automate command for compliances

  def test_help_output_using_automate_cmd
    out = run_inspec_process("automate help")

    assert_includes out.stdout, "inspec automate exec PROFILE"

    assert_exit_code 0, out
  end

  def test_logout_command_using_automate_cmd
    out = run_inspec_process("automate logout")

    assert_includes out.stdout, ""

    assert_exit_code 0, out
  end

  def test_error_login_with_invalid_url_using_automate_cmd
    out = run_inspec_process("automate login")

    assert_includes out.stderr, 'ERROR: "inspec automate login" was called with no arguments'

    assert_exit_code 1, out
  end

  def test_profile_list_without_auth_using_automate_cmd
    out = run_inspec_process("automate profiles")

    assert_includes out.stdout, "You need to login first with `inspec automate login`"

    assert_exit_code 0, out # TODO: make this error
  end

  def test_error_upload_without_args_using_automate_cmd
    out = run_inspec_process("automate upload")

    assert_includes out.stderr, 'ERROR: "inspec automate upload" was called with no arguments'

    assert_exit_code 1, out
  end

  def test_error_upload_with_fake_path_using_automate_cmd
    out = run_inspec_process("automate upload /path/to/dir")

    assert_includes out.stdout, "You need to login first with `inspec automate login`"

    assert_exit_code 0, out # TODO: make this error
  end
end
