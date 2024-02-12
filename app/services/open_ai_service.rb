# frozen_string_literal: true

# api通信とモデルに関するロジック
class OpenAiService
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_drink_words(keyword)
    response = @client.chat(
      parameters: {
        model: 'gpt-4-1106-preview',
        # model: "gpt-3.5-turbo-1106",
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: "あなたは花言葉と飲み物に関するソムリエです。次に続くのはドリンク名です。
          このドリンク名を元にドリンク言葉、ドリンク情報を生成して
          ドリンク名、ドリンク言葉、ドリンク情報として各回答をjson形式で提供してください。
          ドリンク言葉は(花言葉のように)そのドリンクに関連する意味深くキャッチーな言葉にしてください。
          ドリンク名は実際に存在し、一般的に認識されているものにしてください。ドリンク情報は具体的なドリンク情報、由来があれば由来を含めて（約80文字）説明してください。" },
          { role: 'user', content: keyword }
        ],
        max_tokens: 1000,
        temperature: 0.7
      }
    )

    responsed_drink_data(response)
    # Rails.logger.info "OpenAI API Response: #{response.inspect}"
  rescue StandardError => e
    # エラーハンドリング: ログにエラーを記録
    Rails.logger.error("OpenAI API Error: #{e.message}")
    nil
  end

  def generate_story_drink_words(story)
    response = @client.chat(
      parameters: {
        model: 'gpt-4-1106-preview',
        # model: "gpt-3.5-turbo-1106",
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: "あなたは花言葉と飲み物に関するソムリエです。次に続くのはドリンクに関する情報のリクエストです。
          このリクエストを元にオススメの飲み物を提案してください。具体的な商品名も含めて提案してください。
          ドリンク名、ドリンク言葉、ドリンク情報を生成し各回答をjson形式で提供してください。
          ドリンク言葉は(花言葉のように)そのドリンクに関連する意味深くキャッチーな言葉にしてください。
          ドリンク名は実際に存在し、一般的に認識されているものにしてください。ドリンク情報は具体的なドリンク情報、由来があれば由来を含めて（約80文字）説明してください。" },
          { role: 'user', content: story }
        ],
        max_tokens: 1000,
        temperature: 0.7
      }
    )

    responsed_drink_data(response)
  rescue StandardError => e
    # エラーハンドリング: ログにエラーを記録
    Rails.logger.error("OpenAI API Error: #{e.message}")
    nil
  end

  def generate_image(drink_name)
    response = @client.images.generate(
    parameters: {
    model: "dall-e-2",
    prompt: "#{drink_name}の飲み物をクローズアップで撮影したような画像を生成してください。背景は白からグレーのグラデーションで、飲み物の質感や色彩が際立つようにしてください。光の反射や陰影を使って、写真のようなリアリズムを表現してください。",
    size: "256x256",
    response_format: "b64_json" # Base64エンコーディングされた画像データをリクエスト
    })

  # Base64エンコーディングされた画像データを取得
  response.dig("data", 0, "b64_json")
  # 取得したBase64データの先頭部分をログに出力
  # Rails.logger.info "取得したBase64データの先頭: #{base64_data[0..100]}"
  rescue StandardError => e
  # エラーハンドリング: ログに日本語でエラーを記録
    Rails.logger.error("OpenAI画像生成APIエラー: #{e.message}")
    nil
  end

  private

  def responsed_drink_data(response)
    # レスポンスからデータを取得
    data = response.dig('choices', 0, 'message', 'content')
    # データが存在しない場合、メソッドを終了
    return unless data

    Rails.logger.info "Raw API Response: #{data}" # ログ確認用
    # JSON文字列をハッシュに変換
    parsed_data = JSON.parse(data)
    result = {
      drink_name: parsed_data['ドリンク名'],
      drink_word: parsed_data['ドリンク言葉'],
      drink_info: parsed_data['ドリンク情報']
    }

    Rails.logger.info "API Response Data: #{result.inspect}" # ログ確認用
    result
  end
end
