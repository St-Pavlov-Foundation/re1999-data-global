module("modules.logic.character.view.recommed.CharacterDevelopGoalsItem", package.seeall)

local var_0_0 = class("CharacterDevelopGoalsItem", ListScrollCell)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "title/#image_icon")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "title/traced/#go_unselect")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "title/traced/#go_select")
	arg_1_0._btntraced = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "title/traced/#btn_traced")
	arg_1_0._scrollgroup = gohelper.findChild(arg_1_0.viewGO, "#scroll_group")
	arg_1_0._contentgroup = gohelper.findChild(arg_1_0.viewGO, "#scroll_group/Viewport/Content")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_group/#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btntraced:AddClickListener(arg_2_0._btntracedOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_2_0.refreshStatus, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btntraced:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_3_0.refreshStatus, arg_3_0)
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0._btnjumpOnClick(arg_5_0)
	if CharacterRecommedController.instance:jump(arg_5_0._mo) then
		arg_5_0._view:closeThis()
	end
end

function var_0_0._btntracedOnClick(arg_6_0)
	local var_6_0 = arg_6_0._mo:isTraced()

	arg_6_0._mo:setTraced(not var_6_0)
	CharacterRecommedModel.instance:setTracedHeroDevelopGoalsMO(not var_6_0 and arg_6_0._mo)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0._editableAddEvents(arg_8_0)
	return
end

function var_0_0._editableRemoveEvents(arg_9_0)
	return
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_1:getItemList()

	if var_10_0 then
		IconMgr.instance:getCommonPropItemIconList(arg_10_0, arg_10_0._onRewardItemShow, var_10_0, arg_10_0._contentgroup.gameObject)
	end

	local var_10_1, var_10_2 = arg_10_0._mo:getTitleTxtAndIcon()

	arg_10_0._txttitle.text = var_10_1

	if var_10_2 then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_10_0._imageicon, var_10_2)
		gohelper.setActive(arg_10_0._imageicon.gameObject, true)
	else
		gohelper.setActive(arg_10_0._imageicon.gameObject, false)
	end

	arg_10_0:refreshStatus()
	arg_10_0:playViewAnim("goalsitem_open", 0, 0)
end

function var_0_0._onRewardItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:onUpdateMO(arg_11_2)
	arg_11_1:setScale(0.7)
	arg_11_1:setConsume(true)
	arg_11_1:setCountFontSize(38)
	arg_11_1:setRecordFarmItem(arg_11_2)
	arg_11_1:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_11_0)
	arg_11_1:setQuantityText("#cd5353")
end

function var_0_0.refreshStatus(arg_12_0)
	local var_12_0 = arg_12_0._mo:isOwnHero()
	local var_12_1 = arg_12_0._mo:isTraced()

	gohelper.setActive(arg_12_0._btnjump.gameObject, var_12_0 and var_12_1)
	gohelper.setActive(arg_12_0._gounselect.gameObject, var_12_0 and not var_12_1)
	gohelper.setActive(arg_12_0._goselect.gameObject, var_12_0 and var_12_1)
end

function var_0_0.playViewAnim(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._viewAnim then
		arg_13_0._viewAnim = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_13_0._viewAnim then
		arg_13_0._viewAnim:Play(arg_13_1, arg_13_2, arg_13_3)
	end
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	return
end

function var_0_0.onDestroy(arg_15_0)
	return
end

return var_0_0
