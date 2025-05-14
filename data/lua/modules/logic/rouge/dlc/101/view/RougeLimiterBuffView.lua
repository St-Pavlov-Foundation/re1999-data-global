module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffView", package.seeall)

local var_0_0 = class("RougeLimiterBuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochoosebuff = gohelper.findChild(arg_1_0.viewGO, "#go_choosebuff")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_choosebuff/#btn_close")
	arg_1_0._gosmallbuffitem = gohelper.findChild(arg_1_0.viewGO, "#go_choosebuff/SmallBuffView/Viewport/Content/#go_smallbuffitem")
	arg_1_0._gobuffdec = gohelper.findChild(arg_1_0.viewGO, "#go_buffdec")
	arg_1_0._gobuff = gohelper.findChild(arg_1_0.viewGO, "#go_buff")
	arg_1_0._txtchoosebuff = gohelper.findChildText(arg_1_0.viewGO, "#go_choosebuff/txt_choosebuff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.OnSelectBuff, arg_5_0._onSelectBuff, arg_5_0)
	arg_5_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.CloseBuffDescTips, arg_5_0._onCloseBuffDescTips, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenLimiterBuffView)
	arg_6_0:init()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:init()
end

function var_0_0.init(arg_8_0)
	arg_8_0._buffType = arg_8_0.viewParam and arg_8_0.viewParam.buffType

	RougeLimiterBuffListModel.instance:onInit(arg_8_0._buffType)
	arg_8_0:initBuffEntry()
	arg_8_0:refreshTitle()
end

function var_0_0.refreshTitle(arg_9_0)
	local var_9_0 = GameUtil.getRomanNums(arg_9_0._buffType)

	arg_9_0._txtchoosebuff.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougelimiterbuffoverview_txt_buff"), var_9_0)
end

function var_0_0.initBuffEntry(arg_10_0)
	if not arg_10_0._buffEntry then
		local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes.LimiterItem

		arg_10_0._gobufficon = arg_10_0:getResInst(var_10_0, arg_10_0._gobuff, "#go_bufficon")
		arg_10_0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._gobufficon, RougeLimiterBuffEntry)

		arg_10_0._buffEntry:refreshUI()
	end

	arg_10_0._buffEntry:selectBuffEntry(arg_10_0._buffType)
end

function var_0_0._onSelectBuff(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._buffTips then
		arg_11_0._buffTips = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._gobuffdec, RougeLimiterBuffTips)
	end

	arg_11_0._buffTips:onUpdateMO(arg_11_1, arg_11_2)
	gohelper.setActive(arg_11_0._btnclose.gameObject, not arg_11_2)
end

function var_0_0._onCloseBuffDescTips(arg_12_0)
	gohelper.setActive(arg_12_0._btnclose.gameObject, true)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
