# frozen_string_literal: true

require "application_system_test_case"

class SettingSystemTest < ApplicationSystemTestCase
  setup do
    flush_redis
    login_as users(:admin)
  end

  test "update theme" do
    visit setting_url

    choose("user_theme_light")
    click_on("setting_theme_save_button")

    assert_text("Updated successfully")
  end

  test "update media path" do
    visit setting_url

    fill_in("setting_media_path", with: Rails.root.join("test/fixtures/files").to_s)
    click_on("Sync")

    assert_equal "Syncing...", find(:test_id, "media_sync_button").value
    assert_text("Media sync completed")
    assert_equal "Sync", find(:test_id, "media_sync_button").value
  end

  test "update discogs token" do
    visit setting_url

    fill_in("setting_discogs_token", with: "fake_token")
    click_on("setting_discogs_token_save_button")

    assert_text("Updated successfully")
    assert_equal "fake_token", find_field("setting_discogs_token").value
  end
end
