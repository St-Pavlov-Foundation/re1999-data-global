module("modules.logic.season.view1_4.Season1_4HeroGroupCardItem", package.seeall)

local var_0_0 = class("Season1_4HeroGroupCardItem", UserDataDispose)

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
	arg_4_0._equipId = arg_4_2
	arg_4_0._equipUid = arg_4_3
	arg_4_0._layer = Activity104Model.instance:getAct104CurLayer()
	arg_4_0.id = arg_4_1.id
	arg_4_0._hasUseSeasonEquipCard = false
	arg_4_0.hasTrialEquip = arg_4_4

	arg_4_0:updateView()
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	arg_5_0.isActive = arg_5_1
end

function var_0_0.updateView(arg_6_0)
	local var_6_0 = Activity104Model.instance:getCurSeasonId()
	local var_6_1 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_6_0)

	arg_6_0.posUnlock = Activity104Model.instance:isSeasonLayerPosUnlock(var_6_0, var_6_1, arg_6_0._layer, arg_6_0.slot, arg_6_0.id - 1)
	arg_6_0.slotUnlock = Activity104Model.instance:isSeasonLayerSlotUnlock(var_6_0, var_6_1, arg_6_0._layer, arg_6_0.slot)

	if arg_6_0.hasTrialEquip and arg_6_0:getEquipId(var_6_0, var_6_1) == 0 then
		arg_6_0.posUnlock = false
		arg_6_0.slotUnlock = false
	end

	gohelper.setActive(arg_6_0._gocardlock, not arg_6_0.posUnlock)
	gohelper.setActive(arg_6_0._gocardempty, arg_6_0.posUnlock)
	gohelper.setActive(arg_6_0.go, arg_6_0.slotUnlock)

	if arg_6_0.posUnlock then
		local var_6_2 = arg_6_0:getEquipId(var_6_0, var_6_1)

		if var_6_2 ~= 0 then
			if not arg_6_0._seasonCardItem then
				arg_6_0._seasonCardItem = Season1_4CelebrityCardItem.New()

				arg_6_0._seasonCardItem:init(arg_6_0._gocardicon, var_6_2, {
					noClick = true
				})
			else
				gohelper.setActive(arg_6_0._seasonCardItem.go, true)
				arg_6_0._seasonCardItem:reset(var_6_2)
			end

			arg_6_0._hasUseSeasonEquipCard = true
		else
			if arg_6_0._seasonCardItem then
				gohelper.setActive(arg_6_0._seasonCardItem.go, false)
			end

			arg_6_0:playEmptyUnlockAnim()
		end
	elseif arg_6_0._seasonCardItem then
		gohelper.setActive(arg_6_0._seasonCardItem.go, false)
	end
end

function var_0_0.playEmptyUnlockAnim(arg_7_0)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()
	local var_7_1 = arg_7_0.id - 1
	local var_7_2 = arg_7_0.slot
	local var_7_3 = var_7_1 == 4 and 9 or var_7_1 + 1 + 4 * (var_7_2 - 1)

	if Activity104Model.instance:isContainGroupCardUnlockTweenPos(var_7_0, arg_7_0._layer - 1, var_7_3) then
		return
	end

	if not arg_7_0._animcardempty then
		arg_7_0._animcardempty = arg_7_0._gocardempty:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_7_0._animcardempty:Play("lock")
	Activity104Model.instance:setGroupCardUnlockTweenPos(var_7_0, var_7_3)
end

function var_0_0.getEquipId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = HeroGroupModel.instance:getCurGroupMO()

	if var_8_0 and var_8_0.isReplay then
		return arg_8_0._equipId, arg_8_0._equipUid
	end

	if arg_8_0._equipId ~= 0 then
		return arg_8_0._equipId, arg_8_0._equipUid
	end

	if not arg_8_0.slot or not arg_8_0.id then
		return 0
	end

	arg_8_1 = arg_8_1 or Activity104Model.instance:getCurSeasonId()
	arg_8_2 = arg_8_2 or Activity104Model.instance:getSeasonCurSnapshotSubId(arg_8_1)

	return Activity104Model.instance:getSeasonHeroGroupEquipId(arg_8_1, arg_8_2, arg_8_0.slot, arg_8_0.id - 1)
end

function var_0_0.hasUseSeasonEquipCard(arg_9_0)
	return arg_9_0._hasUseSeasonEquipCard
end

function var_0_0._btnCardClick(arg_10_0)
	if arg_10_0.inDrag then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not arg_10_0.id then
		return
	end

	local var_10_0 = Activity104Model.instance:getCurSeasonId()
	local var_10_1 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_10_0)

	if not Activity104Model.instance:isSeasonPosUnlock(var_10_0, var_10_1, arg_10_0.slot, arg_10_0.id - 1) then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	local var_10_2 = {
		group = var_10_1,
		actId = var_10_0,
		pos = arg_10_0.id - 1,
		slot = arg_10_0.slot or 1
	}

	Activity104Controller.instance:openSeasonEquipView(var_10_2)
end

function var_0_0.canDrag(arg_11_0)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if not arg_11_0.posUnlock then
		return false
	end

	local var_11_0, var_11_1 = arg_11_0:getEquipId()

	if not var_11_0 or var_11_0 == 0 or not var_11_1 then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0:canDrag() then
		arg_12_0.inDrag = false

		return
	end

	arg_12_0:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(arg_12_0.parent.go)
	gohelper.setAsLastSibling(arg_12_0.go)

	local var_12_0 = recthelper.screenPosToAnchorPos(arg_12_2.position, arg_12_0.transform)

	arg_12_0:_tweenToPos(arg_12_0._trscard, var_12_0 + var_0_0.DragOffset, true)

	local var_12_1 = var_0_0.ZeroScale * 1.7

	arg_12_0.tweenId = ZProj.TweenHelper.DOScale(arg_12_0._trscard, var_12_1, var_12_1, var_12_1, var_0_0.TweenDuration)
	arg_12_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_12_0._trscard, 0, 0, 0, var_0_0.TweenDuration)
	arg_12_0.inDrag = true
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0:canDrag() then
		arg_13_0.inDrag = false

		return
	end

	local var_13_0 = recthelper.screenPosToAnchorPos(arg_13_2.position, arg_13_0.transform)

	arg_13_0:_tweenToPos(arg_13_0._trscard, var_13_0 + var_0_0.DragOffset)

	arg_13_0.inDrag = true
end

function var_0_0._onEndDrag(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.inDrag = false

	if not arg_14_0:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	arg_14_0:killTweenId()

	local var_14_0 = var_0_0.ZeroScale * 1

	arg_14_0.tweenId = ZProj.TweenHelper.DOScale(arg_14_0._trscard, var_14_0, var_14_0, var_14_0, var_0_0.TweenDuration)

	local var_14_1 = arg_14_0:_moveToTarget(arg_14_2.position)

	arg_14_0:_setDragEnabled(false)

	if not var_14_1 or not var_14_1:canExchange(arg_14_0) then
		arg_14_0:_setToPos(arg_14_0._trscard, var_0_0.ZeroPos, true, arg_14_0._onDragFailTweenEnd, arg_14_0)

		arg_14_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_14_0._trscard, 0, 0, arg_14_0.orignRoteZ, var_0_0.TweenDuration)

		return
	end

	local var_14_2 = recthelper.rectToRelativeAnchorPos(var_14_1.transform.position, arg_14_0.transform)

	arg_14_0:_setToPos(arg_14_0._trscard, var_14_2, true, arg_14_0._onDragSuccessTweenEnd, arg_14_0, var_14_1)

	arg_14_0.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(arg_14_0._trscard, 0, 0, var_14_1.orignRoteZ, var_0_0.TweenDuration)
end

function var_0_0._tweenToPos(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_15_0.posTweenId)

		arg_15_0.posTweenId = nil
	end

	local var_15_0, var_15_1 = recthelper.getAnchor(arg_15_1)

	if math.abs(var_15_0 - arg_15_2.x) > 10 or math.abs(var_15_1 - arg_15_2.y) > 10 then
		arg_15_0.posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_15_1, arg_15_2.x, arg_15_2.y, var_0_0.TweenDuration)
	else
		recthelper.setAnchor(arg_15_1, arg_15_2.x, arg_15_2.y)
	end
end

function var_0_0._setToPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0, var_16_1 = recthelper.getAnchor(arg_16_1)

	if arg_16_3 then
		arg_16_0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_16_1, arg_16_2.x, arg_16_2.y, var_0_0.TweenDuration, arg_16_4, arg_16_5, arg_16_6)
	else
		recthelper.setAnchor(arg_16_1, arg_16_2.x, arg_16_2.y)

		if arg_16_4 then
			arg_16_4(arg_16_5, arg_16_6)
		end
	end
end

function var_0_0._moveToTarget(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.parent:getHeroItemList()

	if var_17_0 then
		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			for iter_17_2 = 1, 2 do
				local var_17_1 = iter_17_1[string.format("_cardItem%s", iter_17_2)]

				if var_17_1 ~= arg_17_0 then
					local var_17_2 = var_17_1.trsRect
					local var_17_3 = recthelper.screenPosToAnchorPos(arg_17_1, var_17_2)

					if math.abs(var_17_3.x) * 2 < recthelper.getWidth(var_17_2) and math.abs(var_17_3.y) * 2 < recthelper.getHeight(var_17_2) then
						return var_17_1
					end
				end
			end
		end
	end

	return nil
end

function var_0_0._setDragEnabled(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.parent:getHeroItemList()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		for iter_18_2 = 1, 2 do
			local var_18_1 = iter_18_1[string.format("_cardItem%s", iter_18_2)]

			if var_18_1 then
				var_18_1:setDragEnabled(arg_18_1)
			end
		end
	end
end

function var_0_0.setDragEnabled(arg_19_0, arg_19_1)
	if arg_19_0._drag then
		arg_19_0._drag.enabled = arg_19_1
	end
end

function var_0_0.canExchange(arg_20_0, arg_20_1)
	if arg_20_1 == arg_20_0 then
		return false
	end

	if not arg_20_1.posUnlock or not arg_20_0.posUnlock then
		return false
	end

	if not arg_20_1.isActive or not arg_20_0.isActive then
		return false
	end

	if arg_20_1.hasTrialEquip or arg_20_0.hasTrialEquip then
		return false
	end

	local var_20_0 = arg_20_1:getEquipId()
	local var_20_1 = arg_20_1.id - 1
	local var_20_2 = arg_20_1.slot
	local var_20_3 = SeasonConfig.instance:getSeasonEquipCo(var_20_0)
	local var_20_4 = arg_20_0:getEquipId()
	local var_20_5 = arg_20_0.id - 1
	local var_20_6 = arg_20_0.slot
	local var_20_7 = SeasonConfig.instance:getSeasonEquipCo(var_20_4)
	local var_20_8 = Activity104EquipItemListModel.instance:getEquipMaxCount(var_20_5)
	local var_20_9 = Activity104Model.instance:getCurSeasonId()
	local var_20_10 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_20_9)

	for iter_20_0 = 1, var_20_8 do
		if iter_20_0 ~= var_20_6 then
			local var_20_11 = Activity104Model.instance:getSeasonHeroGroupEquipId(var_20_9, var_20_10, iter_20_0, var_20_5)
			local var_20_12 = SeasonConfig.instance:getSeasonEquipCo(var_20_11)

			if var_20_3 and var_20_12 and var_20_12.group == var_20_3.group and var_20_1 ~= var_20_5 then
				GameFacade.showToast(Season1_4EquipItem.Toast_Same_Card)

				return false
			end
		end

		if iter_20_0 ~= var_20_2 then
			local var_20_13 = Activity104Model.instance:getSeasonHeroGroupEquipId(var_20_9, var_20_10, iter_20_0, var_20_1)
			local var_20_14 = SeasonConfig.instance:getSeasonEquipCo(var_20_13)

			if var_20_7 and var_20_14 and var_20_14.group == var_20_7.group and var_20_1 ~= var_20_5 then
				GameFacade.showToast(Season1_4EquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	return true
end

function var_0_0._onDragFailTweenEnd(arg_21_0)
	arg_21_0:_setDragEnabled(true)
	gohelper.setAsLastSibling(arg_21_0.parent._cardItem1.go)
end

function var_0_0._onDragSuccessTweenEnd(arg_22_0, arg_22_1)
	arg_22_0:killTweenId()
	arg_22_0:_setToPos(arg_22_0._trscard, var_0_0.ZeroPos)
	arg_22_0:_setToPos(arg_22_1._trscard, var_0_0.ZeroPos)
	transformhelper.setLocalRotation(arg_22_0._trscard, 0, 0, arg_22_0.orignRoteZ)
	arg_22_0:_setDragEnabled(true)
	gohelper.setAsLastSibling(arg_22_0.parent._cardItem1.go)

	local var_22_0, var_22_1 = arg_22_1:getEquipId()
	local var_22_2 = arg_22_1.id - 1
	local var_22_3 = arg_22_1.slot
	local var_22_4, var_22_5 = arg_22_0:getEquipId()
	local var_22_6 = arg_22_0.id - 1
	local var_22_7 = arg_22_0.slot
	local var_22_8 = Activity104Model.instance:getSeasonCurSnapshotSubId()

	Activity104EquipController.instance:exchangeEquip(var_22_6, var_22_7, var_22_5, var_22_2, var_22_3, var_22_1, var_22_8)
end

function var_0_0.killTweenId(arg_23_0)
	if arg_23_0.tweenId then
		ZProj.TweenHelper.KillById(arg_23_0.tweenId)

		arg_23_0.tweenId = nil
	end

	if arg_23_0.rotaTweenId then
		ZProj.TweenHelper.KillById(arg_23_0.rotaTweenId)

		arg_23_0.rotaTweenId = nil
	end

	if arg_23_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_23_0.moveTweenId)

		arg_23_0.moveTweenId = nil
	end

	if arg_23_0.posTweenId then
		ZProj.TweenHelper.KillById(arg_23_0.posTweenId)

		arg_23_0.posTweenId = nil
	end
end

function var_0_0.destory(arg_24_0)
	if arg_24_0._drag then
		arg_24_0._drag:RemoveDragBeginListener()
		arg_24_0._drag:RemoveDragListener()
		arg_24_0._drag:RemoveDragEndListener()
	end

	arg_24_0:killTweenId()
	arg_24_0:__onDispose()
end

return var_0_0
