module("modules.logic.character.view.CharacterTalentChessFilterItem", package.seeall)

local var_0_0 = class("CharacterTalentChessFilterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "#go_using")
	arg_1_0._txtstylename = gohelper.findChildText(arg_1_0.viewGO, "layout/#txt_stylename")
	arg_1_0._gocareer = gohelper.findChild(arg_1_0.viewGO, "layout/#go_career")
	arg_1_0._txtlabel = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_career/#txt_label")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	TalentStyleModel.instance:UseStyle(arg_4_0._heroId, arg_4_0._mo)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._styleslot = gohelper.findChildImage(arg_5_0.viewGO, "layout/slot")
	arg_5_0._styleicon = gohelper.findChildImage(arg_5_0.viewGO, "layout/slot/icon")
	arg_5_0._styleglow = gohelper.findChildImage(arg_5_0.viewGO, "layout/slot/glow")
	arg_5_0._unlock = gohelper.findChild(arg_5_0.viewGO, "unlock")
	arg_5_0._layoutCanvasGroup = gohelper.findChild(arg_5_0.viewGO, "layout"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._heroId = TalentStyleModel.instance._heroId

	arg_8_0:refreshItem()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.hideUnlockAnim, arg_10_0)
end

function var_0_0.showItemState(arg_11_0)
	gohelper.setActive(arg_11_0._goselect, arg_11_0._mo._isUnlock and arg_11_0._mo._isSelect)
	gohelper.setActive(arg_11_0._gousing, arg_11_0._mo._isUnlock and arg_11_0._mo._isUse)
	gohelper.setActive(arg_11_0._golocked, not arg_11_0._mo._isUnlock)

	if arg_11_0._mo._isUnlock then
		local var_11_0 = arg_11_0._mo._styleId

		if var_11_0 ~= 0 and TalentStyleModel.instance:isPlayAnim(arg_11_0._heroId, var_11_0) then
			arg_11_0._isPlayAnim = true

			gohelper.setActive(arg_11_0._unlock, true)
			TalentStyleModel.instance:setPlayAnim(arg_11_0._heroId, var_11_0)
			TaskDispatcher.runDelay(arg_11_0.hideUnlockAnim, arg_11_0, 0.5)
		end
	elseif not arg_11_0._isPlayAnim then
		arg_11_0:hideUnlockAnim()
	end

	arg_11_0._layoutCanvasGroup.alpha = arg_11_0._mo._isUnlock and 1 or 0.5
end

function var_0_0.hideUnlockAnim(arg_12_0)
	gohelper.setActive(arg_12_0._unlock, false)

	arg_12_0._isPlayAnim = false
end

function var_0_0.refreshItem(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0._mo:getStyleTagIcon()
	local var_13_2, var_13_3 = arg_13_0._mo:getStyleTag()

	arg_13_0._txtstylename.text = var_13_2
	arg_13_0._txtlabel.text = var_13_3

	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_13_0._styleslot, var_13_1, true)

	local var_13_4 = arg_13_0._mo._isUse

	if var_13_4 then
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_13_0._styleicon, var_13_0, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_13_0._styleglow, var_13_0, true)
	end

	arg_13_0._styleicon.enabled = var_13_4
	arg_13_0._styleglow.enabled = var_13_4

	arg_13_0:showItemState()
end

return var_0_0
