$: << File.join(File.dirname(__FILE__), "/../lib" )

require 'spec'
require 'rumblr'

def mock_successful(request)
  responses_to = { 
    :authenticate         => successful_authenticate_xml, 
    :anonymous_read       => successful_anonymous_read_xml,
    :authenticated_read   => successful_authenticated_read_xml,
    :authenticated_write  => successful_authenticated_write_xml 
  }
  
  @client = Rumblr::Client.instance
  if request == :authenticated_write
    @client.stub!(:complete_request).and_return(responses_to[request])
  else
    # yes, this is cheating, but for now just concerned that xml is parsed right
    @client.stub!(:complete_request).and_yield(responses_to[request])
  end
end

def successful_authenticate_xml
  response = <<-EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <tumblr version="1.0">
      <user can-upload-audio="1" can-upload-aiff="1" can-upload-video="0" vimeo-login-url="http://www.vimeo.com/services/foo"/>
      <tumblelog title="" name="foo" url="http://foo.com/" type="public" avatar-url="http://assets.tumblr.com/images/default_avatar_foo.gif" is-primary="yes"/>
      <tumblelog title="bar" private-id="000000"  type="private"/>
    </tumblr>
    EOF
  response.strip!
end

def successful_anonymous_read_xml
  response = <<-EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <tumblr version="1.0">
      <tumblelog name="dummylog" timezone="US/Eastern" title="dummy tumblelog title">dummylog description</tumblelog>
      <posts start="0" total="7">
        <post id="78846368" url="http://dummylog.tumblr.com/post/78846368" type="video" date-gmt="2009-02-16 19:11:45 GMT" date="Mon, 16 Feb 2009 14:11:45" unix-timestamp="1234811505">
          <video-caption>public video post caption</video-caption>
          <video-source>http://www.youtube.com/watch?v=rPaWZOM1LnY</video-source>
          <video-player>&lt;object width="400" height="336"&gt;&lt;param name="movie" value="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1"&gt;&lt;/param&gt;&lt;param name="wmode" value="transparent"&gt;&lt;/param&gt;&lt;param name="allowFullScreen" value="true"&gt;&lt;/param&gt;&lt;embed src="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1" type="application/x-shockwave-flash" width="400" height="336" allowFullScreen="true" wmode="transparent"&gt;&lt;/embed&gt;&lt;/object&gt;</video-player>
          <tag>sale</tag>
          <tag>music</tag>
        </post>
        <post id="78846080" url="http://dummylog.tumblr.com/post/78846080" type="audio" date-gmt="2009-02-16 19:10:20 GMT" date="Mon, 16 Feb 2009 14:10:20" unix-timestamp="1234811420" audio-plays="0">
          <audio-caption>public audio post description</audio-caption><audio-player>&lt;embed type="application/x-shockwave-flash" src="http://dummylog.tumblr.com/swf/audio_player.swf?audio_file=http://www.tumblr.com/audio_file/78846080/TofwJxqCAk12g1e0ClxHx7gh&amp;color=FFFFFF" height="27" width="207" quality="best"&gt;&lt;/embed&gt;</audio-player>
          <tag>sale</tag>
        </post>
        <post id="78844911" url="http://dummylog.tumblr.com/post/78844911" type="conversation" date-gmt="2009-02-16 19:04:48 GMT" date="Mon, 16 Feb 2009 14:04:48" unix-timestamp="1234811088">
          <conversation-title>public chat post title</conversation-title>
          <conversation-text>me: public&#13;
    you: chat&#13;
    me: post&#13;
    you: dialogue</conversation-text><conversation><line name="me" label="me:">public&#13;</line><line name="you" label="you:">chat&#13;</line><line name="me" label="me:">post&#13;</line><line name="you" label="you:">dialogue</line></conversation><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">public&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">chat&#13;</conversation-line><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">post&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">dialogue</conversation-line>
          <tag>sale</tag>
        </post>
        <post id="78844351" url="http://dummylog.tumblr.com/post/78844351" type="link" date-gmt="2009-02-16 19:02:00 GMT" date="Mon, 16 Feb 2009 14:02:00" unix-timestamp="1234810920">
          <link-text>public link post name</link-text><link-url>http://www.google.com</link-url>
          <link-description>public link post description</link-description>
          <tag>sale</tag>
        </post>
        <post id="78844076" url="http://dummylog.tumblr.com/post/78844076" type="quote" date-gmt="2009-02-16 19:01:06 GMT" date="Mon, 16 Feb 2009 14:01:06" unix-timestamp="1234810866">
          <quote-text>public quote post content</quote-text>
          <quote-source>public quote post source</quote-source>
          <tag>sale</tag>
        </post>
        <post id="78841604" url="http://dummylog.tumblr.com/post/78841604" type="regular" date-gmt="2009-02-16 18:50:00 GMT" date="Mon, 16 Feb 2009 13:50:00" unix-timestamp="1234810200">
          <regular-title>public text post title</regular-title>
          <regular-body>public text post body</regular-body>
          <tag>sale</tag>
        </post>
        <post id="78841444" url="http://dummylog.tumblr.com/post/78841444" type="photo" date-gmt="2009-02-16 18:49:00 GMT" date="Mon, 16 Feb 2009 13:49:00" unix-timestamp="1234810140">
          <photo-caption>public photo post</photo-caption>
          <photo-url max-width="500">http://21.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_500.jpg</photo-url>
          <photo-url max-width="400">http://1.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_400.jpg</photo-url>
          <photo-url max-width="250">http://22.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_250.jpg</photo-url>
          <photo-url max-width="100">http://19.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_100.jpg</photo-url>
          <photo-url max-width="75">http://2.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_75sq.jpg</photo-url>
          <tag>sale</tag>
        </post>
      </posts>
    </tumblr>
  EOF
  response.strip!
end

def successful_authenticated_read_xml
  response = <<-EOF
  <?xml version="1.0" encoding="UTF-8"?>
  <tumblr version="1.0"><tumblelog name="dummylog" timezone="US/Eastern" title="dummy tumblelog title">dummy tumblelog description</tumblelog><posts start="0" total="7"><post id="78846474" url="http://dummylog.tumblr.com/post/78846474" type="video" date-gmt="2009-02-16 19:12:00 GMT" date="Mon, 16 Feb 2009 14:12:00" unix-timestamp="1234811520" private="true"><video-caption>private video post caption</video-caption><video-source>http://www.youtube.com/watch?v=rPaWZOM1LnY</video-source><video-player>&lt;object width="400" height="336"&gt;&lt;param name="movie" value="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1"&gt;&lt;/param&gt;&lt;param name="wmode" value="transparent"&gt;&lt;/param&gt;&lt;param name="allowFullScreen" value="true"&gt;&lt;/param&gt;&lt;embed src="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1" type="application/x-shockwave-flash" width="400" height="336" allowFullScreen="true" wmode="transparent"&gt;&lt;/embed&gt;&lt;/object&gt;</video-player><tag>sale</tag><tag>tag2</tag><tag>music</tag></post><post id="78846368" url="http://dummylog.tumblr.com/post/78846368" type="video" date-gmt="2009-02-16 19:11:00 GMT" date="Mon, 16 Feb 2009 14:11:00" unix-timestamp="1234811460"><video-caption>public video post caption</video-caption><video-source>hilhttp://www.youtube.com/watch?v=rPaWZOM1LnY</video-source><video-player>&lt;object width="400" height="336"&gt;&lt;param name="movie" value="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1"&gt;&lt;/param&gt;&lt;param name="wmode" value="transparent"&gt;&lt;/param&gt;&lt;param name="allowFullScreen" value="true"&gt;&lt;/param&gt;&lt;embed src="http://www.youtube.com/v/rPaWZOM1LnY&amp;amp;rel=0&amp;amp;egm=0&amp;amp;showinfo=0&amp;amp;fs=1" type="application/x-shockwave-flash" width="400" height="336" allowFullScreen="true" wmode="transparent"&gt;&lt;/embed&gt;&lt;/object&gt;</video-player><tag>hilarious</tag></post><post id="78846150" url="http://dummylog.tumblr.com/post/78846150" type="audio" date-gmt="2009-02-16 19:10:43 GMT" date="Mon, 16 Feb 2009 14:10:43" unix-timestamp="1234811443" private="true" audio-plays="2"><audio-caption>private audio post description</audio-caption><audio-player>&lt;embed type="application/x-shockwave-flash" src="http://dummylog.tumblr.com/swf/audio_player.swf?audio_file=http://www.tumblr.com/audio_file/78846150/TofwJxqCAk12gje4UYRllUwM&amp;color=FFFFFF" height="27" width="207" quality="best"&gt;&lt;/embed&gt;</audio-player><tag>sale</tag></post><post id="78846080" url="http://dummylog.tumblr.com/post/78846080" type="audio" date-gmt="2009-02-16 19:10:00 GMT" date="Mon, 16 Feb 2009 14:10:00" unix-timestamp="1234811400" audio-plays="0"><audio-caption>public audio post description</audio-caption><audio-player>&lt;embed type="application/x-shockwave-flash" src="http://dummylog.tumblr.com/swf/audio_player.swf?audio_file=http://www.tumblr.com/audio_file/78846080/TofwJxqCAk12g1e0ClxHx7gh&amp;color=FFFFFF" height="27" width="207" quality="best"&gt;&lt;/embed&gt;</audio-player><tag>sale</tag><tag>music</tag></post><post id="78844968" url="http://dummylog.tumblr.com/post/78844968" type="conversation" date-gmt="2009-02-16 19:05:08 GMT" date="Mon, 16 Feb 2009 14:05:08" unix-timestamp="1234811108" private="true"><conversation-title>private chat post title</conversation-title><conversation-text>me: private&#13;
  you: chat&#13;
  me: post&#13;
  you: dialogue</conversation-text><conversation><line name="me" label="me:">private&#13;</line><line name="you" label="you:">chat&#13;</line><line name="me" label="me:">post&#13;</line><line name="you" label="you:">dialogue</line></conversation><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">private&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">chat&#13;</conversation-line><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">post&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">dialogue</conversation-line><tag>sale</tag></post><post id="78844911" url="http://dummylog.tumblr.com/post/78844911" type="conversation" date-gmt="2009-02-16 19:04:48 GMT" date="Mon, 16 Feb 2009 14:04:48" unix-timestamp="1234811088"><conversation-title>public chat post title</conversation-title><conversation-text>me: public&#13;
  you: chat&#13;
  me: post&#13;
  you: dialogue</conversation-text><conversation><line name="me" label="me:">public&#13;</line><line name="you" label="you:">chat&#13;</line><line name="me" label="me:">post&#13;</line><line name="you" label="you:">dialogue</line></conversation><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">public&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">chat&#13;</conversation-line><conversation-line name="me" label="me:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">post&#13;</conversation-line><conversation-line name="you" label="you:" deprecated="conversation-line is deprecated and will soon be removed. Use ./conversation/line.">dialogue</conversation-line><tag>sale</tag></post><post id="78844625" url="http://dummylog.tumblr.com/post/78844625" type="link" date-gmt="2009-02-16 19:03:00 GMT" date="Mon, 16 Feb 2009 14:03:00" unix-timestamp="1234810980" private="true"><link-text>private link post name</link-text><link-url>http://www.google.com</link-url><link-description>private link post description</link-description><tag>sale</tag></post><post id="78844351" url="http://dummylog.tumblr.com/post/78844351" type="link" date-gmt="2009-02-16 19:02:00 GMT" date="Mon, 16 Feb 2009 14:02:00" unix-timestamp="1234810920"><link-text>public link post name</link-text><link-url>http://www.google.com</link-url><link-description>public link post description</link-description><tag>sale</tag></post><post id="78844076" url="http://dummylog.tumblr.com/post/78844076" type="quote" date-gmt="2009-02-16 19:01:06 GMT" date="Mon, 16 Feb 2009 14:01:06" unix-timestamp="1234810866"><quote-text>public quote post content</quote-text><quote-source>public quote post source</quote-source><tag>sale</tag></post><post id="78844136" url="http://dummylog.tumblr.com/post/78844136" type="quote" date-gmt="2009-02-16 19:01:00 GMT" date="Mon, 16 Feb 2009 14:01:00" unix-timestamp="1234810860" private="true"><quote-text>private quote post content</quote-text><quote-source>private quote post content</quote-source><tag>sale</tag></post><post id="78843778" url="http://dummylog.tumblr.com/post/78843778" type="photo" date-gmt="2009-02-16 18:59:40 GMT" date="Mon, 16 Feb 2009 13:59:40" unix-timestamp="1234810780" private="true"><photo-caption>private photo post</photo-caption><photo-url max-width="500">http://7.media.tumblr.com/TofwJxqCAk122bofvQLGsl89o1_500.jpg</photo-url><photo-url max-width="400">http://6.media.tumblr.com/TofwJxqCAk122bofvQLGsl89o1_400.jpg</photo-url><photo-url max-width="250">http://11.media.tumblr.com/TofwJxqCAk122bofvQLGsl89o1_250.jpg</photo-url><photo-url max-width="100">http://11.media.tumblr.com/TofwJxqCAk122bofvQLGsl89o1_100.jpg</photo-url><photo-url max-width="75">http://22.media.tumblr.com/TofwJxqCAk122bofvQLGsl89o1_75sq.jpg</photo-url><tag>sale</tag></post><post id="78843501" url="http://dummylog.tumblr.com/post/78843501" type="regular" date-gmt="2009-02-16 18:58:00 GMT" date="Mon, 16 Feb 2009 13:58:00" unix-timestamp="1234810680" private="true"><regular-title>private text post title</regular-title><regular-body>private text post body</regular-body><tag>sale</tag></post><post id="78841604" url="http://dummylog.tumblr.com/post/78841604" type="regular" date-gmt="2009-02-16 18:50:00 GMT" date="Mon, 16 Feb 2009 13:50:00" unix-timestamp="1234810200"><regular-title>public text post title</regular-title><regular-body>public text post body</regular-body><tag>sale</tag></post><post id="78841444" url="http://dummylog.tumblr.com/post/78841444" type="photo" date-gmt="2009-02-16 18:49:00 GMT" date="Mon, 16 Feb 2009 13:49:00" unix-timestamp="1234810140"><photo-caption>public photo post</photo-caption><photo-url max-width="500">http://21.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_500.jpg</photo-url><photo-url max-width="400">http://1.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_400.jpg</photo-url><photo-url max-width="250">http://22.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_250.jpg</photo-url><photo-url max-width="100">http://19.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_100.jpg</photo-url><photo-url max-width="75">http://2.media.tumblr.com/TofwJxqCAk11p5psVgVhLwzJo1_75sq.jpg</photo-url><tag>sale</tag></post></posts></tumblr>
  EOF
  response.strip!
end

def successful_authenticated_write_xml
  "10001"
end
