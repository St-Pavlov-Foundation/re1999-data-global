module("modules.logic.season.view.SeasonHeroGroupCardItem", package.seeall)

local var_0_0 = class("SeasonHeroGroupCardItem", UserDataDispose)

var_0_0.TweenDuration = 0.16
var_0_0.DragOffset = Vector2(0, 40)
var_0_0.ZeroPos = Vector2(-2.7, -5)
var_0_0.ZeroScale = 0.39

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.parent = arg_1_2
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.param = arg_1_3
	arg_1_0.slot = arg_1_3.slot

	arg_1_0:init()
end

function var_0_0.init(arg_2_0)
	arg_2_0._gocardempty = gohelper.findChild(arg_2_0.go, "go_empty")
	arg_2_0._gocardicon = gohelper.findChild(arg_2_0.go, "go_card")
	arg_2_0._trscard = arg_2_0._gocardicon.transform
	arg_2_0._gocardlock = gohelper.findChild(arg_2_0.go, "go_lock")
	arg_2_0._btncardclick = gohelper.findChildButtonWithAudio(arg_2_0.go, "btn_click")
	arg_2_0.trsRect = arg_2_0._btncardclick.transform

	arg_2_0:addClickCb(arg_2_0._btncardclick, arg_2_0._btnCardClick, arg_2_0)
	arg_2_0:AddDrag(arg_2_0._btncardclick.gameObject)

	local var_2_0, var_2_1, var_2_2 = transformhelper.getLocalRotation(arg_2_0._trscard)

	arg_2_0.orignRoteZ = var_2_2
end

function var_0_0.AddDrag(arg_3_0, arg_3_1)
	if arg_3_0._drag then
		return
	end

	arg_3_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_3_1)

	arg_3_0._drag:AddDragBeginListener(arg_3_0._onBeginDrag, arg_3_0, arg_3_1.transform)
	arg_3_0._drag:AddDragListener(arg_3_0._onDrag, arg_3_0)
	arg_3_0._drag:AddDragEndListener(arg_3_0._onEndDrag, arg_3_0, arg_3_1.transform)
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._equipId = arg_4_3
	arg_4_0._equipUid = arg_4_4
	arg_4_0._layer = arg_4_2 or Activity104Model.instance:getAct104CurLayer()
	arg_4_0.id = arg_4_1.id
	arg_4_0._hasUseSeasonEquipCard = false

	arg_4_0:updateView()
end

function var_0_0.updateView(arg_5_0)
	local var_5_0 = Activity104Model.instance:getCurSeasonId()
	local var_5_1 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_5_0)

	arg_5_0.posUnlock = Activity104Model.instance:isSeasonLayerPosUnlock(var_5_0, var_5_1, arg_5_0._layer, arg_5_0.slot, arg_5_0.id - 1)
	arg_5_0.slotUnlock = Activity104Model.instance:isSeasonLayerSlotUnlock(var_5_0, var_5_1, arg_5_0._layer, arg_5_0.slot)

	gohelper.setActive(arg_5_0._gocardlock, not arg_5_0.posUnlock)
	gohelper.setActive(arg_5_0._gocardempty, arg_5_0.posUnlock)
	gohelper.setActive(arg_5_0.go, arg_5_0.slotUnlock)

	if arg_5_0.posUnlock then
		local var_5_2 = arg_5_0:getEquipId(var_5_0, var_5_1)

		if var_5_2 ~= 0 then
			if not arg_5_0._seasonCardItem then
				arg_5_0._seasonCardItem = SeasonCelebrityCardItem.New()

				arg_5_0._seasonCardItem:init(arg_5_0._gocardicon, var_5_2, {
					noClick = true
				})
			else
				gohelper.setActive(arg_5_0._seasonCardItem.go, true)
				arg_5_0._seasonCardItem:reset(var_5_2)
			end

			arg_5_0._hasUseSeasonEquipCard = true
		else
			if arg_5_0._seasonCardItem then
				gohelper.setActive(arg_5_0._seasonCardItem.go, false)
			end

			arg_5_0:playEmptyUnlockAnim()
		end
	elseif arg_5_0._seasonCardItem then
		gohelper.setActive(arg_5_0._seasonCardItem.go, false)
	end
end

function var_0_0.playEmptyUnlockAnim(arg_6_0)
	local var_6_0 = Activity104Model.instance:getCurSeasonId()
	local var_6_1 = arg_6_0.id - 1
	local var_6_2 = arg_6_0.slot
	local var_6_3 = var_6_1 == 4 and 9 or var_6_1 + 1 + 4 * (var_6_2 - 1)

	if Activity104Model.instance:isContainGroupCardUnlockTweenPos(var_6_0, arg_6_0._layer - 1, var_6_3) then
		return
	end

	if not arg_6_0._animcardempty then
		arg_6_0._animcardempty = arg_6_0._gocardempty:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_6_0._animcardempty:Play("lock")
	Activity104Model.instance:setGroupCardUnlockTweenPos(var_6_0, var_6_3)
end

function var_0_0.getEquipId(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = HeroGroupModel.instance:getCurGroupMO()

	if var_7_0 and var_7_0.isReplay then
		return arg_7_0._equipId, arg_7_0._equipUid
	end

	if arg_7_0._equipId ~= 0 then
		return arg_7_0._equipId, arg_7_0._equipUid
	end

	if not arg_7_0.slot or not arg_7_0.id then
		return 0
	end

	arg_7_1 = arg_7_1 or Activity104Model.instance:getCurSeasonId()
	arg_7_2 = arg_7_2 or Activity104Model.instance:getSeasonCurSnapshotSubId(arg_7_1)

	return Activity104Model.instance:getSeasonHeroGroupEquipId(arg_7_1, arg_7_2, arg_7_0.slot, arg_7_0.id - 1)
end

function var_0_0.hasUseSeasonEquipCard(arg_8_0)
	return arg_8_0._hasUseSeasonEquipCard
end

function var_0_0._btnCardClick(arg_9_0)
	if arg_9_0.inDrag then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not arg_9_0.id then
		return
	end

	local var_9_0 = Activity104Model.instance:getCurSeasonId()
	local var_9_1 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_9_0)

	if not Activity104Model.instance:isSeasonPosUnlock(var_9_0, var_9_1, arg_9_0.slot, arg_9_0.id - 1) then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	local var_9_2 = {
		group = var_9_1,
		actId = var_9_0,
		pos = arg_9_0.id - 1,
		slot = arg_9_0.slot or 1
	}

	Activity104Controller.instance:openSeasonEquipView(var_9_2)
end

function var_0_0.canDrag(arg_10_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if not arg_10_0.posUnlock then
		return false
	end

	local var_10_0 = arg_10_0:getEquipId()

	if not var_10_0 or var_10_0 == 0 then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0:canDrag() then
		arg_11_0.inDrag = false

		return
	end

	arg_11_0:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(arg_11_0.parent.go)
	gohelper.setAsLastSibling(arg_11_0.go)

	local var_11_0 = recthelper.screenPosToAnchorPos(arg_11_2.position, arg_11_0.transform)

	arg_11_0:_tweenToPos(arg_11_0._trscard, var_11_0 + var_0_0.DragOffset, true)

	local var_11_1 = var_0_0.ZeroScale * 1.7

	arg_11_0.tweenId = ZProj.TweenHelper.DOScale(arg_11_0._trscard, var_11_1, var_11_1, var_11_1, var_0_0.TweenDuration)
	arg_11_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_11_0._trscard, 0, 0, 0, var_0_0.TweenDuration)
	arg_11_0.inDrag = true
end

function var_0_0._onDrag(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0:canDrag() then
		arg_12_0.inDrag = false

		return
	end

	local var_12_0 = recthelper.screenPosToAnchorPos(arg_12_2.position, arg_12_0.transform)

	arg_12_0:_tweenToPos(arg_12_0._trscard, var_12_0 + var_0_0.DragOffset)

	arg_12_0.inDrag = true
end

function var_0_0._onEndDrag(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.inDrag = false

	if not arg_13_0:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	arg_13_0:killTweenId()

	local var_13_0 = var_0_0.ZeroScale * 1

	arg_13_0.tweenId = ZProj.TweenHelper.DOScale(arg_13_0._trscard, var_13_0, var_13_0, var_13_0, var_0_0.TweenDuration)

	local var_13_1 = arg_13_0:_moveToTarget(arg_13_2.position)

	arg_13_0:_setDragEnabled(false)

	if not var_13_1 or not var_13_1:canExchange(arg_13_0) then
		arg_13_0:_setToPos(arg_13_0._trscard, var_0_0.ZeroPos, true, arg_13_0._onDragFailTweenEnd, arg_13_0)

		arg_13_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_13_0._trscard, 0, 0, arg_13_0.orignRoteZ, var_0_0.TweenDuration)

		return
	end

	local var_13_2 = recthelper.rectToRelativeAnchorPos(var_13_1.transform.position, arg_13_0.transform)

	arg_13_0:_setToPos(arg_13_0._trscard, var_13_2, true, arg_13_0._onDragSuccessTweenEnd, arg_13_0, var_13_1)

	arg_13_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_13_0._trscard, 0, 0, var_13_1.orignRoteZ, var_0_0.TweenDuration)
end

function var_0_0._tweenToPos(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_14_0.posTweenId)

		arg_14_0.posTweenId = nil
	end

	local var_14_0, var_14_1 = recthelper.getAnchor(arg_14_1)

	if math.abs(var_14_0 - arg_14_2.x) > 10 or math.abs(var_14_1 - arg_14_2.y) > 10 then
		arg_14_0.posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_14_1, arg_14_2.x, arg_14_2.y, var_0_0.TweenDuration)
	else
		recthelper.setAnchor(arg_14_1, arg_14_2.x, arg_14_2.y)
	end
end

function var_0_0._setToPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	local var_15_0, var_15_1 = recthelper.getAnchor(arg_15_1)

	if arg_15_3 then
		arg_15_0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_15_1, arg_15_2.x, arg_15_2.y, var_0_0.TweenDuration, arg_15_4, arg_15_5, arg_15_6)
	else
		recthelper.setAnchor(arg_15_1, arg_15_2.x, arg_15_2.y)

		if arg_15_4 then
			arg_15_4(arg_15_5, arg_15_6)
		end
	end
end

function var_0_0._moveToTarget(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.parent:getHeroItemList()

	if var_16_0 then
		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			for iter_16_2 = 1, 2 do
				local var_16_1 = iter_16_1[string.format("_cardItem%s", iter_16_2)]

				if var_16_1 ~= arg_16_0 then
					local var_16_2 = var_16_1.trsRect
					local var_16_3 = recthelper.screenPosToAnchorPos(arg_16_1, var_16_2)

					if math.abs(var_16_3.x) * 2 < recthelper.getWidth(var_16_2) and math.abs(var_16_3.y) * 2 < recthelper.getHeight(var_16_2) then
						return var_16_1
					end
				end
			end
		end
	end

	return nil
end

function var_0_0._setDragEnabled(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.parent:getHeroItemList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		for iter_17_2 = 1, 2 do
			local var_17_1 = iter_17_1[string.format("_cardItem%s", iter_17_2)]

			if var_17_1 then
				var_17_1:setDragEnabled(arg_17_1)
			end
		end
	end
end

function var_0_0.setDragEnabled(arg_18_0, arg_18_1)
	if arg_18_0._drag then
		arg_18_0._drag.enabled = arg_18_1
	end
end

function var_0_0.canExchange(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0 then
		return false
	end

	if not arg_19_1.posUnlock or not arg_19_0.posUnlock then
		return false
	end

	local var_19_0 = arg_19_1:getEquipId()
	local var_19_1 = arg_19_1.id - 1
	local var_19_2 = arg_19_1.slot
	local var_19_3 = SeasonConfig.instance:getSeasonEquipCo(var_19_0)
	local var_19_4 = arg_19_0:getEquipId()
	local var_19_5 = arg_19_0.id - 1
	local var_19_6 = arg_19_0.slot
	local var_19_7 = SeasonConfig.instance:getSeasonEquipCo(var_19_4)
	local var_19_8 = Activity104EquipItemListModel.instance:getEquipMaxCount(var_19_5)
	local var_19_9 = Activity104Model.instance:getCurSeasonId()
	local var_19_10 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_19_9)

	for iter_19_0 = 1, var_19_8 do
		if iter_19_0 ~= var_19_6 then
			local var_19_11 = Activity104Model.instance:getSeasonHeroGroupEquipId(var_19_9, var_19_10, iter_19_0, var_19_5)
			local var_19_12 = SeasonConfig.instance:getSeasonEquipCo(var_19_11)

			if var_19_3 and var_19_12 and var_19_12.group == var_19_3.group and var_19_1 ~= var_19_5 then
				GameFacade.showToast(SeasonEquipItem.Toast_Same_Card)

				return false
			end
		end

		if iter_19_0 ~= var_19_2 then
			local var_19_13 = Activity104Model.instance:getSeasonHeroGroupEquipId(var_19_9, var_19_10, iter_19_0, var_19_1)
			local var_19_14 = SeasonConfig.instance:getSeasonEquipCo(var_19_13)

			if var_19_7 and var_19_14 and var_19_14.group == var_19_7.group and var_19_1 ~= var_19_5 then
				GameFacade.showToast(SeasonEquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	return true
end

function var_0_0._onDragFailTweenEnd(arg_20_0)
	arg_20_0:_setDragEnabled(true)
	gohelper.setAsLastSibling(arg_20_0.parent._cardItem1.go)
end

function var_0_0._onDragSuccessTweenEnd(arg_21_0, arg_21_1)
	arg_21_0:killTweenId()
	arg_21_0:_setToPos(arg_21_0._trscard, var_0_0.ZeroPos)
	arg_21_0:_setToPos(arg_21_1._trscard, var_0_0.ZeroPos)
	transformhelper.setLocalRotation(arg_21_0._trscard, 0, 0, arg_21_0.orignRoteZ)
	arg_21_0:_setDragEnabled(true)
	gohelper.setAsLastSibling(arg_21_0.parent._cardItem1.go)

	local var_21_0, var_21_1 = arg_21_1:getEquipId()
	local var_21_2 = arg_21_1.id - 1
	local var_21_3 = arg_21_1.slot
	local var_21_4, var_21_5 = arg_21_0:getEquipId()
	local var_21_6 = arg_21_0.id - 1
	local var_21_7 = arg_21_0.slot
	local var_21_8 = Activity104Model.instance:getCurSeasonId()
	local var_21_9 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_21_8)

	Activity104EquipController.instance:exchangeEquip(var_21_6, var_21_7, var_21_5, var_21_2, var_21_3, var_21_1, var_21_8, var_21_9)
end

function var_0_0.killTweenId(arg_22_0)
	if arg_22_0.tweenId then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId)

		arg_22_0.tweenId = nil
	end

	if arg_22_0.rotaTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.rotaTweenId)

		arg_22_0.rotaTweenId = nil
	end

	if arg_22_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.moveTweenId)

		arg_22_0.moveTweenId = nil
	end

	if arg_22_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.posTweenId)

		arg_22_0.posTweenId = nil
	end
end

function var_0_0.destory(arg_23_0)
	if arg_23_0._drag then
		arg_23_0._drag:RemoveDragBeginListener()
		arg_23_0._drag:RemoveDragListener()
		arg_23_0._drag:RemoveDragEndListener()
	end

	arg_23_0:killTweenId()
	arg_23_0:__onDispose()
end

return var_0_0
