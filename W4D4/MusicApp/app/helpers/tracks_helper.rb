module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    lines = lyrics.strip.split("\r\n")
    lines.map! { |line| "&#9835; " + h(line) }
    "<pre>#{lines.join("\n")}</pre>".html_safe
  end
end
