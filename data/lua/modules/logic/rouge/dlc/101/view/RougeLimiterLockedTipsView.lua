module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsView", package.seeall)

local var_0_0 = class("RougeLimiterLockedTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrolltips = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tips")
	arg_1_0._imagebufficon = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/top/#image_bufficon")
	arg_1_0._txtbufflevel = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/top/#txt_bufflevel")
	arg_1_0._txtbuffname = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/top/#txt_buffname")
	arg_1_0._godesccontainer = gohelper.findChild(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	arg_1_0._txtdecitem = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#txt_tips")

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
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshUnlockedTips()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeLimiterLockedTips)
end

function var_0_0.refreshUnlockedTips(arg_8_0)
	arg_8_0._limiterGroupId = arg_8_0.viewParam and arg_8_0.viewParam.limiterGroupId

	local var_8_0 = RougeDLCConfig101.instance:getLimiterGroupCo(arg_8_0._limiterGroupId)
	local var_8_1 = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(arg_8_0._limiterGroupId)
	local var_8_2 = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(arg_8_0._limiterGroupId, var_8_1)
	local var_8_3

	var_8_3 = var_8_2 and var_8_2.id
	arg_8_0._txtbufflevel.text = GameUtil.getRomanNums(var_8_1)
	arg_8_0._txtbuffname.text = var_8_0 and var_8_0.title
	arg_8_0._txttips.text = var_8_0 and var_8_0.desc

	UISpriteSetMgr.instance:setRouge4Sprite(arg_8_0._imagebufficon, var_8_0.icon)
	arg_8_0:_refreshLimiterGroupDesc()
end

function var_0_0._refreshLimiterGroupDesc(arg_9_0)
	local var_9_0 = RougeDLCConfig101.instance:getAllLimiterCosInGroup(arg_9_0._limiterGroupId)

	gohelper.CreateObjList(arg_9_0, arg_9_0._refreshGroupDesc, var_9_0, arg_9_0._godesccontainer, arg_9_0._txtdecitem.gameObject)
end

function var_0_0._refreshGroupDesc(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.onceAddComponent(arg_10_1, gohelper.Type_TextMesh).text = arg_10_2 and arg_10_2.desc
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
