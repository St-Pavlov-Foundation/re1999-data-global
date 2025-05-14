module("modules.logic.character.view.destiny.CharacterDestinyUnlockStoneComp", package.seeall)

local var_0_0 = class("CharacterDestinyUnlockStoneComp", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._txtdragtip = gohelper.findChildText(arg_1_0.viewGO, "txt_dragtip")
	arg_1_0._gostone = gohelper.findChild(arg_1_0.viewGO, "#go_stone")
	arg_1_0._simagestone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_stone/#simage_stone")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goeffect = gohelper.findChild(arg_7_0.viewGO, "effectItem")
	arg_7_0._effectItems = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_7_0 = arg_7_0:getEffectItem(iter_7_0)
		local var_7_1, var_7_2 = recthelper.getAnchor(var_7_0.go.transform)

		var_7_0.orignAnchor = {
			x = var_7_1,
			y = var_7_2
		}
	end

	arg_7_0._imagestone = gohelper.findChildImage(arg_7_0.viewGO, "#go_stone/#simage_stone")
	arg_7_0._imagestone.color = Color(0.5, 0.5, 0.5, 1)
	arg_7_0._linempc = gohelper.findChild(arg_7_0.viewGO, "#go_line"):GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_7_0._effectmpc = arg_7_0._goeffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return
	end

	if arg_8_0._isSuccessUnlock[arg_8_1] then
		return
	end

	local var_8_0 = arg_8_0._effectItems[arg_8_1]

	if not var_8_0 or not var_8_0.isCanDrag then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_resonate_property_click)
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	if arg_9_0._isSuccessUnlock[arg_9_1] then
		return
	end

	local var_9_0 = arg_9_0._effectItems[arg_9_1]

	if not var_9_0 or not var_9_0.isCanDrag then
		return
	end

	local var_9_1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_9_0.viewGO.transform)

	recthelper.setAnchor(var_9_0.go.transform, var_9_1.x, var_9_1.y)
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1

	if arg_10_0._isSuccessUnlock[var_10_0] then
		return
	end

	local var_10_1 = arg_10_0._effectItems[var_10_0]

	if not var_10_1 or not var_10_1.isCanDrag then
		return
	end

	if Vector2.Distance(var_10_1.go.transform.anchoredPosition, Vector2.zero) < 300 then
		arg_10_0:_finishDrag(var_10_0)
	else
		arg_10_0:_returnOrginPos(var_10_0)
	end
end

function var_0_0._returnOrginPos(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._effectItems[arg_11_1]
	local var_11_1 = var_11_0.go.transform.anchoredPosition
	local var_11_2 = var_11_0.orignAnchor
	local var_11_3 = Vector2.Distance(var_11_1, Vector2(var_11_2.x, var_11_2.y)) * 0.001
	local var_11_4 = Mathf.Clamp(var_11_3, 0.5, 1)

	var_11_0.tweenId = ZProj.TweenHelper.DOAnchorPos(var_11_0.go.transform, var_11_2.x, var_11_2.y, var_11_4)
end

function var_0_0._finishDrag(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._effectItems[arg_12_1]

	var_12_0.anim:Play(CharacterDestinyEnum.StoneViewAnim.Close, 0, 0)
	gohelper.setActive(var_12_0.glow, true)

	arg_12_0._isSuccessUnlock[arg_12_1] = true

	TaskDispatcher.runDelay(arg_12_0._checkAllFinish, arg_12_0, 0.9)

	var_12_0.isCanDrag = false

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_runes_put)
end

function var_0_0._checkAllFinish(arg_13_0)
	if arg_13_0:_checkAllDragFinish() then
		if arg_13_0._stoneView then
			AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_lifestone_unlock)
			arg_13_0._stoneView:playUnlockstoneAnim(CharacterDestinyEnum.StoneViewAnim.LevelUp, arg_13_0._onUnlockStone, arg_13_0)
			arg_13_0._stoneView:onUnlockStone()
		else
			arg_13_0:_onUnlockStone()
		end
	end
end

function var_0_0._onUnlockStone(arg_14_0)
	CharacterDestinyController.instance:onUnlockStone(arg_14_0.heroId, arg_14_0.stoneId)
end

function var_0_0._checkAllDragFinish(arg_15_0)
	for iter_15_0 = 1, CharacterDestinyEnum.EffectItemCount do
		if not arg_15_0._isSuccessUnlock[iter_15_0] then
			return false
		end
	end

	return true
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onUpdateMo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._isSuccessUnlock = {}
	arg_17_0.heroId = arg_17_1
	arg_17_0.stoneId = arg_17_2

	local var_17_0 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_17_2)

	arg_17_0._simagestone:LoadImage(ResUrl.getDestinyIcon(var_17_0.icon))

	for iter_17_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_17_1 = arg_17_0:getEffectItem(iter_17_0)

		var_17_1.isCanDrag = true

		var_17_1.anim:Play(CharacterDestinyEnum.StoneViewAnim.Idle, 0, 0)

		if var_17_1.tweenId then
			ZProj.TweenHelper.KillById(var_17_1.tweenId)

			var_17_1.tweenId = nil
		end

		if var_17_1.orignAnchor then
			recthelper.setAnchor(var_17_1.go.transform, var_17_1.orignAnchor.x, var_17_1.orignAnchor.y)
		end

		local var_17_2 = CharacterDestinyEnum.SlotTend[var_17_0.tend].RuneColor

		if arg_17_0._linempc.color_01 ~= var_17_2 then
			arg_17_0._linempc.color_01 = var_17_2

			arg_17_0._linempc:SetProps()
		end

		if arg_17_0._effectmpc.color_01 ~= var_17_2 then
			arg_17_0._effectmpc.color_01 = var_17_2

			arg_17_0._effectmpc:SetProps()
		end

		gohelper.setActive(var_17_1.glow, false)
	end

	TaskDispatcher.cancelTask(arg_17_0._checkAllFinish, arg_17_0)
end

function var_0_0.setStoneView(arg_18_0, arg_18_1)
	arg_18_0._stoneView = arg_18_1
end

function var_0_0.getEffectItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._effectItems[arg_19_1]

	if not var_19_0 then
		local var_19_1 = gohelper.findChild(arg_19_0._goeffect, arg_19_1)
		local var_19_2 = gohelper.findChild(var_19_1, "txt")

		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.go = var_19_1
		var_19_0.txt = var_19_2
		var_19_0.txtglow = gohelper.findChildImage(var_19_1, "#txt_glow")
		var_19_0.drag = SLFramework.UGUI.UIDragListener.Get(var_19_2.gameObject)

		var_19_0.drag:AddDragBeginListener(arg_19_0._onDragBegin, arg_19_0, arg_19_1)
		var_19_0.drag:AddDragListener(arg_19_0._onDrag, arg_19_0, arg_19_1)
		var_19_0.drag:AddDragEndListener(arg_19_0._onDragEnd, arg_19_0, arg_19_1)

		var_19_0.anim = var_19_1:GetComponent(typeof(UnityEngine.Animator))

		local var_19_3 = gohelper.findChild(arg_19_0.viewGO, "#go_line/#mesh0" .. arg_19_1)

		var_19_0.glow = gohelper.findChild(var_19_3, "#glow")
		var_19_0.isCanDrag = true
		arg_19_0._effectItems[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroy(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._effectItems) do
		iter_21_1.drag:RemoveDragBeginListener()
		iter_21_1.drag:RemoveDragListener()
		iter_21_1.drag:RemoveDragEndListener()

		if iter_21_1.tweenId then
			ZProj.TweenHelper.KillById(iter_21_1.tweenId)

			iter_21_1.tweenId = nil
		end
	end

	arg_21_0._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(arg_21_0._checkAllFinish, arg_21_0)
end

return var_0_0
