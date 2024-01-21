class OpenAiService
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_drink_words(keyword)
    response = @client.chat(
      parameters: {
        model: "gpt-4-1106-preview",
        #model: "gpt-3.5-turbo-1106",
        response_format: { type: "json_object" },
        messages: [
          {role: "system", content: "あなたはドリンクに関するエキスパートです。次に続くのはドリンクに関する情報のリクエストです。
          第1候補はドリンク名、ドリンク言葉、ドリンク情報について各回答をjson形式で提供してください。
          第2、第3候補はドリンク名のみ回答し、他候補という名目でjson形式で提供してください。
          ドリンク言葉は(花言葉のように)そのドリンクに関連する意味深くキャッチーな言葉にしてください。
          ドリンク名は実際に存在し、一般的に認識されているものにしてください。ドリンク情報は具体的なドリンク情報、由来があれば由来を含めて（約80文字）説明してください。"},
          {role: "user", content: keyword}
        ],
        max_tokens: 1000,
        temperature: 0.5
      })

    responsed_drink_data(response)
  rescue StandardError => e
    # エラーハンドリング: ログにエラーを記録
    Rails.logger.error("OpenAI API Error: #{e.message}")
    nil
  end

  #def generate_image_url(drink_name)
    #response = @client.images.generate(
      #parameters: {
        #model: "dall-e-2",
        #prompt: "#{drink_name}の飲み物をクローズアップで撮影したような画像を生成してください。背景は白からグレーのグラデーションで、飲み物の質感や色彩が際立つようにしてください。光の反射や陰影を使って、写真のようなリアリズムを表現してください。",
        #size: "256x256"
      #})

    #response.dig("data", 0, "url")
  #rescue StandardError => e
    # エラーハンドリング: ログに日本語でエラーを記録
    #Rails.logger.error("OpenAI画像生成APIエラー: #{e.message}")
    #nil
  #end

  private

  def responsed_drink_data(response)
    #レスポンスからデータを取得
    data = response.dig("choices", 0, "message", "content")
    #データが存在しない場合、メソッドを終了
    return unless data
    # JSON文字列をハッシュに変換
    parsed_data = JSON.parse(data)
    {
      first_candidate: {
        drink_name: parsed_data.dig("第1候補", "ドリンク名"),
        drink_word: parsed_data.dig("第1候補", "ドリンク言葉"),
        drink_info: parsed_data.dig("第1候補", "ドリンク情報")
      },
      second_candidate: parsed_data.dig("第2候補", "ドリンク名"),
      third_candidate: parsed_data.dig("第3候補", "ドリンク名")
    }

  end
end
