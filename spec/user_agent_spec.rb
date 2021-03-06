require File.dirname(__FILE__) + '/spec_helper.rb'

describe UserAgent do
  
  EXAMPLES = {
    "" => [], 
    
    # Chrome
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/534.1 (KHTML, like Gecko) Chrome/6.0.437.2 Safari/534.1" =>
      ["Chrome", "6.0.437.2", "Mac OS X", "10.6.4"],
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.53 Safari/525.19" =>
      ["Chrome", "1.0.154.53", "Windows", "XP"],
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.1 (KHTML, like Gecko) Chrome/5.0.322.2 Safari/533.1" =>
      ["Chrome", "5.0.322.2", "Windows", "7"],
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-US) AppleWebKit/532.9 (KHTML, like Gecko) Chrome/5.0.307.11 Safari/532.9" =>
      ["Chrome", "5.0.307.11", "Mac OS X", "10.6.2"],
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/532.5 (KHTML, like Gecko) Chrome/4.0.249.78 Safari/532.5" =>
      ["Chrome", "4.0.249.78", "Windows", "7"],
    "Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.198.0 Safari/532.0" =>
      ["Chrome", "3.0.198.0", "Linux"],
      
    # ChromeFrame
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; chromeframe; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)" =>
      ["ChromeFrame", nil, "Windows", "Vista"],
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; chromeframe; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)" =>
      ["ChromeFrame", nil, "Windows", "Vista"], 
    
    # MSIE  
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; FunWebProducts; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; InfoPath.1)" =>
      ["MSIE", "8.0", "Windows", "Vista"],
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; .NET CLR 3.5.30729; .NET CLR 3.0.30618)" =>
      ["MSIE", "7.0", "Windows", "Vista"], 
    "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)" =>
      ["MSIE", "5.5", "Windows", "XP"],
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; MDDC)" =>
      ["MSIE", "8.0", "Windows", "7"],
    
     # Firefox
     "Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.8.0.3) Gecko/20060426 Firefox/1.5.0.3" =>
       ["Firefox", "1.5.0.3", "Windows", "ME"], 
     "Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9b5) Gecko/2008032620 Firefox/3.0b5" =>
       ["Firefox", "3.0b5", "Windows", "Vista"],
     "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.2) Gecko/2008092313 Ubuntu/8.04 (hardy) Firefox/3.1.6" =>
       ["Firefox", "3.1.6", "Linux", "Ubuntu 8.04"],
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; es-ES; rv:1.9.1) Gecko/20090624 Firefox/3.5" =>
      ["Firefox", "3.5", "Windows", "XP"], 
    "Mozilla/5.0 (Windows; U; Win98; de-DE; rv:1.7) Gecko/20040803 Firefox/0.9.3" =>
      ["Firefox", "0.9.3", "Windows", "98"], 
    "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.8.1.18) Gecko/20081029 Firefox/2.0.0.18" =>
      ["Firefox", "2.0.0.18", "Windows", "XP"], 
    "Mozilla/5.0 (X11; U; OpenBSD i386; en-US; rv:1.8.1.7) Gecko/20070930 Firefox/2.0.0.7" =>
      ["Firefox", "2.0.0.7", "OpenBSD"],
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3" =>
      ["Firefox", "3.6.3", "Mac OS X", "10.6"],
    "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.5; en-US; rv:1.9.0.3) Gecko/2008092414 Firefox/3.0.3" =>
      ["Firefox", "3.0.3", "Mac OS X", "10.5"],
      
    # Firefox Fennec
    "Mozilla/5.0 (X11; U; Linux armv61; en-US; rv:1.9.1b2pre) Gecko/20081015 Fennec/1.0a1" =>
      ["Firefox Fennec", "1.0a1", nil, nil],
    "Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.8.1.17) Gecko/20080829 Mozilla/5.0 (X11; U; Linux armv7l; en-US; rv:1.9.2a1pre) Gecko/20090322 Fennec/1.0b2pre" =>
      ["Firefox Fennec", "1.0b2pre", nil, nil],
    
    # Opera
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; en) Opera 8.0" =>
      ["Opera", "8.0", "Windows", "2000"],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 4.0; en) Opera 8.0" =>
      ["Opera", "8.0", "Windows", "NT"],
    "Opera/9.02 (Windows NT 5.1; U; pt-br)" =>
      ["Opera", "9.02", "Windows", "XP"],
    "Opera/9.52 (Windows NT 6.0; U; Opera/9.52 (X11; Linux x86_64; U); en)" =>
      ["Opera", "9.52", "Windows", "Vista"],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 6.0; en) Opera 9.50" =>
      ["Opera", "9.50", "Windows", "Vista"],
    "Mozilla/5.0 (Windows NT 5.1; U; en-GB; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.61" =>
      ["Opera", "9.61", "Windows", "XP"], 
    "Opera/9.62 (X11; Linux i686; U; en) Presto/2.1.1" => 
      ["Opera", "9.62", "Linux"],
    "Opera/9.80 (Windows NT 5.1; U; cs) Presto/2.2.15 Version/10.00" =>
      ["Opera", "10.00", "Windows", "XP"],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; PPC; 480x640) Opera 8.60 [en]" =>
      ["Opera", "8.60", "Windows", "CE"],
    
    # Opera Mini 
    "Opera/9.60 (J2ME/MIDP; Opera Mini/4.2.13918/516; U; de) Presto/2.2.0" =>
      ["Opera Mini", "9.60"], 
    
    # Opera Mobile 
    "Opera/9.51 Beta (Microsoft Windows; PPC; Opera Mobi/1718; U; en)" =>
      ["Opera Mobile", "9.51", "Windows", nil], 
    
    # Safari
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16" =>
      ["Safari", "5.0", "Mac OS X", "10.6.3"],
    "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_6; it-it) AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16" =>
      ["Safari", "4.0", "Mac OS X", "10.5.6"], 
    "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; fr) AppleWebKit/412.7 (KHTML, like Gecko) Safari/412.5" =>
      ["Safari", "2.0.1", "Mac OS X"], 
    "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_2; en-gb) AppleWebKit/526+ (KHTML, like Gecko) Version/3.1 iPhone" =>
      ["Safari", "3.1", "Mac OS X", "10.5.2"], 
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; sv-se) AppleWebKit/525.26.2 (KHTML, like Gecko) Version/3.2 Safari/525.26.12" =>
      ["Safari", "3.2", "Mac OS X", "10.5.5"],
    
    # Safari Mobile
    "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092816 Mobile Safari 1.1.3" =>
      ["Safari Mobile", nil, "Linux", nil],
    "Mozilla/5.0 (iPhone; U; CPU iPhone OS 2_1 like Mac OS X; fr-fr) AppleWebKit/525.18.1 (KHTML, like Gecko) Mobile/5F136" =>
      ["Safari Mobile", nil, "iPhone", "2.1"],
    "Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B367 Safari/531.21.10" =>
      ["Safari Mobile", "4.0.4", "iPad", "3.2"],
    "Mozilla/5.0 (iPod; U; CPU iPhone OS 2_2_1 like Mac OS X; de-de) AppleWebKit/525.18.1 (KHTML, like Gecko) Mobile/5H11a" =>
      ["Safari Mobile", nil, "iPhone", "2.2.1"],
      
    # Prism
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9b4pre) Gecko/2008030313 Prism/0.9" =>
      ["Prism", "0.9", "Mac OS X", "10.4"], 
    "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9a9pre) Gecko/2007110108 prism/0.8" =>
      ["Prism", "0.8", "Windows", "Vista"],
      
    # Fluid
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; de-de) AppleWebKit/528.16 (KHTML, like Gecko) Fluid/0.9.6 Safari/528.16" =>
      ["Fluid", "0.9.6", "Mac OS X", "10.5.7"],
      
    # Blackberry
    "BlackBerry9700/5.0.0.351 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/123" =>
      ["BlackBerry Browser", nil, "BlackBerry OS", "5.0.0.351"],
    "BlackBerry8703e/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/105" =>
      ["BlackBerry Browser", nil, "BlackBerry OS", "4.1.0"],
      
    # Palm
    "Mozilla/5.0 (webOS/1.0; U; en-US) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/1.1 Safari/525.27.1 Pre/1.0" =>
      ["Palm webkit", "1.1", "Palm webOS", "1.0"],
    "PalmCentro/v0001 Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; PalmSource/Palm-D061; Blazer/4.5) 16;320x320" =>
      [nil, nil, "PalmOS", nil],
    "Mozilla/4.76 [en] (PalmOS; U; WebPro/3.0; Palm-Arz1)" =>
      [nil, nil, "PalmOS", nil],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) /Palm 500v/v0100 UP.Link/6.3.1.13.0" =>
      ["MSIE Mobile", "6.0", "Windows", "CE"],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; PalmSource/Palm-TunX; Blazer/4.3) 16;320x448" =>
      [nil, nil, "PalmOS", nil],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows 95; PalmSource; Blazer 3.0) 16;160x160" =>
      [nil, nil, "PalmOS", nil],
      
    # Windows CE
    "Mozilla/4.0 (compatible; MSIE 4.01; Windows CE; PPC; 240x320)" =>
      ["MSIE Mobile", "4.01", "Windows", "CE"],
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE)" =>
      ["MSIE Mobile", "6.0", "Windows", "CE"],
      
    # SymbianOS
    "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 Nokia6120c/3.83; Profile/MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413" =>
      ["Webkit Mobile", "413", "SymbianOS", "9.2"],
    "Nokia6630/1.0 (2.3.129) SymbianOS/8.0 Series60/2.6 Profile/MIDP-2.0 Configuration/CLDC-1.1" =>
      [nil, nil, "SymbianOS", "8.0"],
    "Mozilla/4.1 (compatible; MSIE 5.0; Symbian OS; Nokia 6600;432) Opera 6.10 [en]" =>
      ["Opera", "6.10", "SymbianOS", nil],
      
    # Special Agents
    "curl/7.7.3 (i686-pc-linux-gnu) libcurl 7.7.3 (OpenSSL 0.9.6)" =>
      ["curl", "7.7.3", "Linux", nil],
    "Googlebot/2.1 (+http://www.google.com/bot.html)" =>
      ["Googlebot", "2.1", nil, nil],
    "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" =>
      ["Googlebot", "2.1", nil, nil]
  }

  EXAMPLES.each do |agent, expected|
    context "user agent sring '#{agent}'" do
      before(:all) do
        @ua = UserAgent.new(agent)
      end
      
      it "detects browser #{expected[0].inspect}" do
        @ua.browser_name.should eql(expected[0])
      end
        
      it "detects browser version #{expected[1].inspect}" do
        @ua.browser_version.should eql(expected[1])
      end
      
      it "detects os #{expected[0].inspect}" do
        @ua.os_name.should eql(expected[2])
      end
      
      it "detects os version #{expected[3].inspect}" do
        @ua.os_version.should eql(expected[3])
      end
    end
  end
  
  it "should return nil for all values on unknown user agents" do
    ua = UserAgent.new("asdf")
    ua.browser_name.should be_nil
    ua.browser_version.should be_nil
    ua.os_name.should be_nil
    ua.os_version.should be_nil
  end
  
  it "should gracefully handle nil values" do
    UserAgent.new(nil).browser_name.should be_nil
  end
  
  describe "#string" do
    it "returns user agent string on known user agent" do
      uas = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; en) Opera 8.0"
      UserAgent.new(uas).string.should eql(uas)
    end
    
    it "returns user agent string on unknown user agent" do
      uas = "whatever/v345"
      UserAgent.new(uas).string.should eql(uas)
    end
  end
  
  describe "#normalized_browser_version" do
    before do
      @ua = UserAgent.new(nil)
    end
    
    it "reduce versions to major.minor" do
      @ua.browser_version = "5.0.307.11"
      @ua.normalized_browser_version.should eql("5.0")
      @ua.browser_version = "9.62"
      @ua.normalized_browser_version.should eql("9.62")
      @ua.browser_version = "0.9.3"
      @ua.normalized_browser_version.should eql("0.9")
    end
    
    it "leaves strings untouched" do
      @ua.browser_version = "3.0b5"
      @ua.normalized_browser_version.should eql("3.0b5")
      @ua.browser_version = "3.0.5.beta"
      @ua.normalized_browser_version.should eql("3.0beta")
      @ua.browser_version = "3.0.5beta"
      @ua.normalized_browser_version.should eql("3.0beta")
      @ua.browser_version = "Mobile 3.1.7 beta"
      @ua.normalized_browser_version.should eql("Mobile 3.1 beta")
    end
    
    it "removes unessecary double zeros" do
      @ua.browser_version = "100.00"
      @ua.normalized_browser_version.should eql("100.0")
    end
    
    it "forces minor" do
      @ua.browser_version = "1"
      @ua.normalized_browser_version.should eql("1.0")
      @ua.browser_version = "1beta"
      @ua.normalized_browser_version.should eql("1.0beta")
    end
    
    it "leaves string without version untouched" do
      @ua.browser_version = "jaja nono"
      @ua.normalized_browser_version.should eql("jaja nono")
    end
  end

  describe "#unknown?" do
    it "returns true on empty result" do
      UserAgent.new(nil).should be_unknown
      UserAgent.new("").should be_unknown
      UserAgent.new("agent you;don't know anything about").should be_unknown
    end
    
    it "returns false if browser name is given" do
      ua = UserAgent.new("")
      ua.browser_name = "I know"
      ua.should_not be_unknown
    end
    
    it "returns true if browser version is given" do
      ua = UserAgent.new("")
      ua.browser_version = "1.2.3"
      ua.should be_unknown
    end
    
    it "returns true if os name is given" do
      ua = UserAgent.new("")
      ua.os_name = "MS Know"
      ua.should be_unknown
    end
    
    it "returns true if browser version is given" do
      ua = UserAgent.new("")
      ua.os_version = "1.2.3"
      ua.should be_unknown
    end
    
    it "returns true if browser name is empty string" do
      ua = UserAgent.new("")
      ua.browser_name = ""
      ua.should be_unknown
    end
  end
end
