module("modules.logic.ressplit.xml.ResSplitXmlPrint", package.seeall)

return {
	starttag = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		io.write("Start    : " .. arg_1_1.name .. "\n")

		if arg_1_1.attrs then
			for iter_1_0, iter_1_1 in pairs(arg_1_1.attrs) do
				io.write(string.format(" + %s='%s'\n", iter_1_0, iter_1_1))
			end
		end
	end,
	endtag = function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		io.write("End      : " .. arg_2_1.name .. "\n")
	end,
	text = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		io.write("Text     : " .. arg_3_1 .. "\n")
	end,
	cdata = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		io.write("CDATA    : " .. arg_4_1 .. "\n")
	end,
	comment = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		io.write("Comment  : " .. arg_5_1 .. "\n")
	end,
	dtd = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		io.write("DTD      : " .. arg_6_1.name .. "\n")

		if arg_6_1.attrs then
			for iter_6_0, iter_6_1 in pairs(arg_6_1.attrs) do
				io.write(string.format(" + %s='%s'\n", iter_6_0, iter_6_1))
			end
		end
	end,
	pi = function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		io.write("PI       : " .. arg_7_1.name .. "\n")

		if arg_7_1.attrs then
			for iter_7_0, iter_7_1 in pairs(arg_7_1.attrs) do
				io.write(string.format(" + %s='%s'\n", iter_7_0, iter_7_1))
			end
		end
	end,
	decl = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		io.write("XML Decl : " .. arg_8_1.name .. "\n")

		if arg_8_1.attrs then
			for iter_8_0, iter_8_1 in pairs(arg_8_1.attrs) do
				io.write(string.format(" + %s='%s'\n", iter_8_0, iter_8_1))
			end
		end
	end
}
