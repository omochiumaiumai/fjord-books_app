# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @report = reports(:one)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    click_on Report.model_name.human
    assert_selector 'h1', text: '日報'
  end

  test 'creating a report' do
    visit books_url
    click_on '日報'
    click_on '新規作成'

    fill_in 'タイトル', with: '今日は'
    fill_in '内容', with: 'とてもよい一日でした。'
    click_on '登録する'

    assert_text '日報が作成されました'
    assert_text '今日は'
    assert_text 'とてもよい一日でした。'
  end

  test 'updating a report' do
    visit books_url
    click_on '日報'
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '更新する'

    assert_text '日報が更新されました。'
  end

  test 'destroying a report' do
    visit books_url
    click_on '日報'
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
