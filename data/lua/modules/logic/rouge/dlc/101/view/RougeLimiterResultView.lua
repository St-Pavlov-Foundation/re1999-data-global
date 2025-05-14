module("modules.logic.rouge.dlc.101.view.RougeLimiterResultView", package.seeall)

local var_0_0 = class("RougeLimiterResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._imagebadge = gohelper.findChildImage(arg_1_0.viewGO, "Single/Top/#image_badge")
	arg_1_0._goadd1 = gohelper.findChild(arg_1_0.viewGO, "Single/Top/#go_add1")
	arg_1_0._txtadd1 = gohelper.findChildText(arg_1_0.viewGO, "Single/Top/#go_add1/#txt_add1")
	arg_1_0._gocurrent1 = gohelper.findChild(arg_1_0.viewGO, "Single/Top/#go_current1")
	arg_1_0._txtcurrent1 = gohelper.findChildText(arg_1_0.viewGO, "Single/Top/#go_current1/#txt_current1")
	arg_1_0._goadd2 = gohelper.findChild(arg_1_0.viewGO, "Two/Top/#go_add2")
	arg_1_0._txtadd2 = gohelper.findChildText(arg_1_0.viewGO, "Two/Top/#go_add2/#txt_add2")
	arg_1_0._gocurrent2 = gohelper.findChild(arg_1_0.viewGO, "Two/Top/#go_current2")
	arg_1_0._txtcurrent2 = gohelper.findChildText(arg_1_0.viewGO, "Two/Top/#go_current2/#txt_current2")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "Two/Bottom/#go_buffitem")
	arg_1_0._imagebufficon = gohelper.findChildImage(arg_1_0.viewGO, "Two/Bottom/#go_buffitem/#image_bufficon")
	arg_1_0._txtbuffname = gohelper.findChildText(arg_1_0.viewGO, "Two/Bottom/#go_buffitem/#txt_buffname")
	arg_1_0._txtbuffdec = gohelper.findChildText(arg_1_0.viewGO, "Two/Bottom/#go_buffitem/#txt_buffdec")
	arg_1_0._btnclosebtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closebtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebtn:AddClickListener(arg_2_0._btnclosebtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebtn:RemoveClickListener()
end

function var_0_0._btnclosebtnOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._gosingle = gohelper.findChild(arg_5_0.viewGO, "Single")
	arg_5_0._gotwo = gohelper.findChild(arg_5_0.viewGO, "Two")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterResultView)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = RougeModel.instance:getRougeResult()
	local var_8_1 = var_8_0 and var_8_0:getLimiterResultMo()
	local var_8_2 = var_8_1 and var_8_1:getLimiterUseBuffIds()
	local var_8_3 = var_8_2 and #var_8_2 > 0
	local var_8_4 = var_8_1 and var_8_1:getLimiterAddEmblem()
	local var_8_5 = var_8_1 and var_8_1:getPreEmbleCount()

	gohelper.setActive(arg_8_0._gosingle, not var_8_3)
	gohelper.setActive(arg_8_0._gotwo, var_8_3)
	arg_8_0:refreshEmblem(var_8_3, var_8_5, var_8_4)
	arg_8_0:refreshCDBuffs(var_8_2)
end

function var_0_0.refreshEmblem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]
	local var_9_1 = var_9_0 and tonumber(var_9_0.value) or 0
	local var_9_2 = GameUtil.clamp(var_9_1 - arg_9_2, 0, var_9_1)
	local var_9_3 = arg_9_3

	if var_9_2 < arg_9_3 then
		var_9_3 = var_9_2
	end

	local var_9_4 = arg_9_2 + var_9_3
	local var_9_5 = string.format("+ %s", var_9_3 or 0)
	local var_9_6 = formatLuaLang("rouge_dlc_101_emblemCount", var_9_4)

	if var_9_1 <= var_9_4 then
		var_9_6 = string.format("%s (MAX)", var_9_6)
	end

	if arg_9_1 then
		arg_9_0._txtadd2.text = var_9_5
		arg_9_0._txtcurrent2.text = var_9_6
	else
		arg_9_0._txtadd1.text = var_9_5
		arg_9_0._txtcurrent1.text = var_9_6
	end
end

function var_0_0.refreshCDBuffs(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1 or {}) do
		local var_10_1 = arg_10_0:_getOrCreateBuffItem(iter_10_0)
		local var_10_2 = RougeDLCConfig101.instance:getLimiterBuffCo(iter_10_1)

		gohelper.setActive(var_10_1.viewGO, true)

		var_10_1.txtTitle.text = var_10_2 and var_10_2.title
		var_10_1.txtDec.text = var_10_2 and var_10_2.desc

		UISpriteSetMgr.instance:setRouge4Sprite(var_10_1.imageIcon, var_10_2.icon)

		var_10_0[var_10_1] = true
	end

	if arg_10_0._buffItemTab then
		for iter_10_2, iter_10_3 in pairs(arg_10_0._buffItemTab) do
			if not var_10_0[iter_10_3] then
				gohelper.setActive(iter_10_3.viewGO, false)
			end
		end
	end
end

function var_0_0._getOrCreateBuffItem(arg_11_0, arg_11_1)
	arg_11_0._buffItemTab = arg_11_0.buffItemTab or arg_11_0:getUserDataTb_()

	local var_11_0 = arg_11_0._buffItemTab[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.viewGO = gohelper.cloneInPlace(arg_11_0._gobuffitem, "buffitem_" .. arg_11_1)
		var_11_0.txtTitle = gohelper.findChildText(var_11_0.viewGO, "#txt_buffname")
		var_11_0.txtDec = gohelper.findChildText(var_11_0.viewGO, "#txt_buffdec")
		var_11_0.imageIcon = gohelper.findChildImage(var_11_0.viewGO, "#image_bufficon")
		arg_11_0._buffItemTab[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
