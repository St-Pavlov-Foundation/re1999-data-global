module("modules.logic.character.view.CharacterTalentChessFilterView", package.seeall)

local var_0_0 = class("CharacterTalentChessFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closefilterview")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_select")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_locked")
	arg_1_0._txtstylename = gohelper.findChildText(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#txt_stylename")
	arg_1_0._gocareer = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career")
	arg_1_0._txtlabel = gohelper.findChildText(arg_1_0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career/#txt_label")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btnclosefilterviewOnClick, arg_2_0)
	arg_2_0:_addEvents()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0:_removeEvents()
end

function var_0_0._btnclosefilterviewOnClick(arg_4_0)
	arg_4_0._animPlayer:Play("close", arg_4_0.closeThis, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtTitleCn = gohelper.findChildText(arg_5_0.viewGO, "container/title/dmgTypeCn")
	arg_5_0._txtTitleEn = gohelper.findChildText(arg_5_0.viewGO, "container/title/dmgTypeCn/dmgTypeEn")
	arg_5_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._heroId = arg_7_0.viewParam.heroId

	local var_7_0 = HeroModel.instance:getByHeroId(arg_7_0._heroId):getTalentTxtByHeroType()
	local var_7_1 = luaLang("talent_style_title_cn_" .. var_7_0)
	local var_7_2 = luaLang("talent_style_title_en_" .. var_7_0)

	arg_7_0._txtTitleCn.text = var_7_1
	arg_7_0._txtTitleEn.text = var_7_2

	TalentStyleModel.instance:openView(arg_7_0._heroId)
	arg_7_0:_refreshVidew()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._addEvents(arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_10_0._onUseTalentStyleReply, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	arg_11_0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_11_0._onUseTalentStyleReply, arg_11_0)
end

function var_0_0._onUseTalentStyleReply(arg_12_0, arg_12_1)
	arg_12_0:_refreshVidew()
end

function var_0_0.onClickModalMask(arg_13_0, arg_13_1)
	arg_13_0:closeThis()
end

function var_0_0._refreshVidew(arg_14_0)
	TalentStyleListModel.instance:refreshData(arg_14_0._heroId)
end

return var_0_0
