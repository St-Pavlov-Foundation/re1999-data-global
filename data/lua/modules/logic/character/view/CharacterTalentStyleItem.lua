module("modules.logic.character.view.CharacterTalentStyleItem", package.seeall)

local var_0_0 = class("CharacterTalentStyleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._txtstyle = gohelper.findChildText(arg_1_0.viewGO, "#txt_style")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "#go_use")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_new")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0._hideNewAnim, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._hideUnlockAnim, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._hideSelectAnim, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo then
		TalentStyleModel.instance:selectCubeStyle(arg_4_0._heroId, arg_4_0._mo._styleId)
		gohelper.setActive(arg_4_0._gonew, false)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._styleslot = gohelper.findChildImage(arg_5_0.viewGO, "slot")
	arg_5_0._styleicon = gohelper.findChildImage(arg_5_0.viewGO, "slot/icon")
	arg_5_0._styleglow = gohelper.findChildImage(arg_5_0.viewGO, "slot/glow")
	arg_5_0._goselectQuan = gohelper.findChild(arg_5_0.viewGO, "#go_select/quan")
	arg_5_0._gohot = gohelper.findChild(arg_5_0.viewGO, "#go_hot")
	arg_5_0._imglock = arg_5_0._golocked:GetComponent(typeof(UnityEngine.UI.Image))
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
	TaskDispatcher.cancelTask(arg_10_0._hideUnlockAnim, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._hideSelectAnim, arg_10_0)
end

function var_0_0.showItemState(arg_11_0)
	gohelper.setActive(arg_11_0._gouse, arg_11_0._mo._isUse)
	gohelper.setActive(arg_11_0._golocked, not arg_11_0._mo._isUnlock)
	gohelper.setActive(arg_11_0._gonormal, arg_11_0._mo._isUnlock)

	local var_11_0 = TalentStyleModel.instance:getNewUnlockStyle()
	local var_11_1 = TalentStyleModel.instance:getNewSelectStyle()

	TaskDispatcher.cancelTask(arg_11_0._hideUnlockAnim, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._hideSelectAnim, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._hideNewAnim, arg_11_0)
	gohelper.setActive(arg_11_0._gounlock, var_11_0 == arg_11_0._mo._styleId)
	gohelper.setActive(arg_11_0._goselectQuan, var_11_1 == arg_11_0._mo._styleId)
	gohelper.setActive(arg_11_0._goselect, arg_11_0._mo._isSelect)

	if var_11_0 == arg_11_0._mo._styleId then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_01)
		TaskDispatcher.runDelay(arg_11_0._hideUnlockAnim, arg_11_0, 0.5)
	end

	if var_11_1 then
		TaskDispatcher.runDelay(arg_11_0._hideSelectAnim, arg_11_0, 0.5)
	end

	gohelper.setActive(arg_11_0._gonew, arg_11_0._mo._isNew)

	arg_11_0._styleglow.color = Color(1, 1, 1, arg_11_0._mo._isUnlock and 1 or 0.3)
	arg_11_0._imglock.color = Color(1, 1, 1, arg_11_0._mo._isUnlock and 1 or 0.5)
	arg_11_0._styleslot.enabled = arg_11_0._mo._isUnlock
	arg_11_0._styleicon.enabled = arg_11_0._mo._isUnlock

	gohelper.setActive(arg_11_0._gohot, arg_11_0._mo:isHotUnlock())
end

function var_0_0._hideUnlockAnim(arg_12_0)
	gohelper.setActive(arg_12_0._gounlock, false)
	TalentStyleModel.instance:setNewUnlockStyle()
end

function var_0_0._hideNewAnim(arg_13_0)
	gohelper.setActive(arg_13_0._gonew, false)

	arg_13_0._isShowNew = false
end

function var_0_0._hideSelectAnim(arg_14_0)
	gohelper.setActive(arg_14_0._goselectQuan, false)
	TalentStyleModel.instance:setNewSelectStyle()
end

function var_0_0.refreshItem(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0._mo:getStyleTagIcon()

	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_15_0._styleslot, var_15_1, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_15_0._styleicon, var_15_0, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_15_0._styleglow, var_15_0, true)
	arg_15_0:showItemState()
end

return var_0_0
