# -*- coding: utf-8; -*-
require File.dirname(__FILE__) + '/../../spec_helper'

require 'tdiary'
require 'tdiary/wiki_style'

describe TDiary::WikiDiary do
	before do
		@diary = TDiary::WikiDiary.new(Time::at( 1041346800 ), "TITLE", "")
	end

	describe 'test_wiki_style' do
		before do
			@source = <<-'EOF'
! subTitle
honbun

!! subTitleH4
honbun

			EOF
			@diary.append(@source)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>honbun</p>
<h4>subTitleH4</h4>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>honbun</p>
<h4>subTitleH4</h4>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end

	describe 'test_wiki_style2' do
		before do
			source = <<-'EOF'
subTitle

honbun

honbun

			EOF
			@diary.append(source)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<p><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></p>
<p>honbun</p>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<p><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></p>
<p>honbun</p>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end

	describe 'test_wiki_style3' do
		before do
			source = <<-'EOF'
subTitle

honbun

honbun

! subTitle

honbun

			EOF
			@diary.append(source)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<p><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></p>
<p>honbun</p>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<p><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></p>
<p>honbun</p>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>honbun</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end

	describe 'test_wiki_style_plugin' do
		before do
			source = <<-'EOF'
! subTitle
{{plugin}}
{{plugin}}
aaa

{{plugin}}

a{{ho
ge}}b

{{ho
ge}}
			EOF
			@diary.append(source)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p><%=plugin
%>
<%=plugin
%>
aaa</p>
<p><%=plugin
%></p>
<p>a<%=ho
ge
%>b</p>
<p><%=ho
ge
%></p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p><%=plugin
%>
<%=plugin
%>
aaa</p>
<p><%=plugin
%></p>
<p>a<%=ho
ge
%>b</p>
<p><%=ho
ge
%></p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end

	describe 'test_wiki_style_kw' do
		before do
			source = <<-'EOF'
! subTitle
[[aaa]]

[[aaa|bbb]]

[[aaa'bbb|ccc]]

[[aaa|aaa]]

[[aaa:鯖]]

[[aaa|bbb:ccc]]

[[aaa'bbb|bbb:ccc]]

[[鯖|http://ja.wikipedia.org/wiki/%E9%AF%96]]

http://ja.wikipedia.org/wiki/%E9%AF%96
			EOF
			@diary.append(source)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p><%=kw 'aaa', 'aaa'%></p>
<p><a href="bbb">aaa</a></p>
<p><a href="ccc">aaa'bbb</a></p>
<p><%=kw 'aaa', 'aaa'%></p>
<p><%=kw 'aaa:鯖'%></p>
<p><%=kw 'bbb:ccc', 'aaa'%></p>
<p><%=kw 'bbb:ccc', 'aaa\'bbb'%></p>
<p><a href="http://ja.wikipedia.org/wiki/%E9%AF%96">鯖</a></p>
<p><a href="http://ja.wikipedia.org/wiki/%E9%AF%96">http://ja.wikipedia.org/wiki/%E9%AF%96</a></p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p><%=kw 'aaa', 'aaa'%></p>
<p><a href="bbb">aaa</a></p>
<p><a href="ccc">aaa'bbb</a></p>
<p><%=kw 'aaa', 'aaa'%></p>
<p><%=kw 'aaa:鯖'%></p>
<p><%=kw 'bbb:ccc', 'aaa'%></p>
<p><%=kw 'bbb:ccc', 'aaa\'bbb'%></p>
<p><a href="http://ja.wikipedia.org/wiki/%E9%AF%96">鯖</a></p>
<p><a href="http://ja.wikipedia.org/wiki/%E9%AF%96">http://ja.wikipedia.org/wiki/%E9%AF%96</a></p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end

	def test_append_without_subtitle
		before do
			source = <<-'EOF'
! subTitle
body
			EOF

			sourceappend 0 <<-'EOF'
appended body
			EOF
			@diary.append(source)
			@diary.append(sourceappend)
		end

		context 'HTML' do
			before do
				@html = <<-'EOF'
<div class="section">
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>body</p>
<p>appended body</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
</div>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}).should eq @html }
		end

		context 'CHTML' do
			before do
				@html = <<-'EOF'
<%=section_enter_proc( Time::at( 1041346800 ) )%>
<h3><%= subtitle_proc( Time::at( 1041346800 ), "subTitle" ) %></h3>
<p>body</p>
<p>appended body</p>
<%=section_leave_proc( Time::at( 1041346800 ) )%>
				EOF
			end
			it { @diary.to_html({'anchor' => true, 'index' => ''}, :CHTML).should eq @html }
		end
	end
end

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
