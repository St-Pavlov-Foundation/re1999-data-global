module("modules.logic.lifecircle.controller.LifeCircleController", package.seeall)

slot0 = class("LifeCircleController", BaseController)
slot1 = table.insert

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._stageid = nil
	slot0._materialDataMOList = nil
	slot0._onReceiveHeroGainPushMsg = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, slot0._onSignInTotalRewardReply, slot0)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, slot0._onReceiveSignInTotalRewardAllReply, slot0)
end

function slot0.sendSignInTotalRewardRequest(slot0, slot1, slot2, slot3)
	SignInRpc.instance:sendSignInTotalRewardRequest(slot1, slot2, slot3)
end

function slot0.sendSignInTotalRewardAllRequest(slot0, slot1, slot2)
	return SignInRpc.instance:sendSignInTotalRewardAllRequest(slot1, slot2)
end

function slot0.sendSignInTotalRewardAllRequestIfClaimable(slot0, slot1, slot2)
	if not slot0:isClaimableAccumulateReward() then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0:sendSignInTotalRewardAllRequest(slot1, slot2)
end

function slot0.sendSignInRequest(slot0)
	slot0:sendSignInTotalRewardAllRequestIfClaimable(SignInRpc.sendSignInRequest, SignInRpc.instance)
end

function slot0.isClaimedAccumulateReward(slot0, slot1)
	return SignInModel.instance:isClaimedAccumulateReward(slot1)
end

function slot0.isClaimableAccumulateReward(slot0, slot1)
	return SignInModel.instance:isClaimableAccumulateReward(slot1)
end

slot2 = -11235

function slot0._onReceiveSignInTotalRewardAllReply(slot0)
	slot0:dispatchRedDotEventUpdateRelateDotInfo()

	slot0._stageid = uv0

	if not slot0._materialDataMOList then
		return
	end

	slot0:_openLifeCircleRewardView()
end

function slot0._onSignInTotalRewardReply(slot0, slot1)
	slot0:dispatchRedDotEventUpdateRelateDotInfo()

	slot0._stageid = slot1

	if not slot0._materialDataMOList then
		return
	end

	slot0:_openLifeCircleRewardView()
end

function slot0.openLifeCircleRewardView(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	slot0._materialDataMOList = slot1

	if not slot0._stageid then
		return
	end

	slot0:_openLifeCircleRewardView()
end

function slot0._openLifeCircleRewardView(slot0)
	if not slot0._stageid then
		return
	end

	if not slot0._materialDataMOList then
		return
	end

	slot1 = slot0._materialDataMOList
	slot3 = 0
	slot0._materialDataMOList = nil
	slot0._stageid = nil

	RoomController.instance:popUpRoomBlockPackageView(slot1)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.LifeCircleRewardView, {
		materialDataMOList = slot1,
		loginDayCount = uv0 == slot0._stageid and (PlayerModel.instance:getPlayinfo().totalLoginDays or 0) or SignInConfig.instance:getSignInLifeTimeBonusCO(slot2).logindaysid
	})
end

function slot0.onReceiveHeroGainPush(slot0, slot1)
	slot0._onReceiveHeroGainPushMsg = slot1
end

function slot0.onReceiveMaterialChangePush(slot0, slot1)
	slot2, slot3, slot4, slot5 = MaterialRpc.receiveMaterial(slot1)

	if not slot2 or #slot2 == 0 then
		slot0._onReceiveHeroGainPushMsg = nil

		return
	end

	slot6 = {}
	slot7 = {}

	for slot11, slot12 in ipairs(slot2) do
		if slot12.materilType == MaterialEnum.MaterialType.Hero then
			uv0(slot6, slot12.materilId)
		else
			uv0(slot7, slot12)
		end
	end

	if #slot6 == 0 then
		if slot0._onReceiveHeroGainPushMsg then
			HeroRpc.instance:_onReceiveHeroGainPush(slot0._onReceiveHeroGainPushMsg)
		end

		MaterialRpc.instance:_onReceiveMaterialChangePush_default(slot1, slot2, slot3, slot4, slot5)
	else
		slot0._onReceiveHeroGainPushMsg = nil

		slot0:_doVirtualSummonBehavior(slot6, slot7)
	end
end

function slot0._doVirtualSummonBehavior(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.BackpackView)
	SummonController.instance:simpleEnterSummonScene(slot1, function ()
		if ViewMgr.instance:isOpen(ViewName.BackpackView) then
			return
		end

		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
		MaterialRpc.instance:simpleShowView(uv0)
	end)
end

function slot0.isShowRed(slot0)
	if slot0:isExistsNewConfig() then
		return true
	end

	if slot0:isClaimableAccumulateReward() then
		return true
	end

	return false
end

slot3 = "LifeCircleController|"

function slot0.getPrefsKeyPrefix(slot0)
	return uv0
end

function slot0.saveInt(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
end

function slot0.getInt(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot1, slot2)
end

slot4 = "NewConfig"

function slot0.setLatestConfigCount(slot0, slot1)
	slot0:saveInt(slot0:getPrefsKeyPrefix() .. uv0, slot1)
end

function slot0.getLatestConfigCount(slot0)
	return slot0:getInt(slot0:getPrefsKeyPrefix() .. uv0, 0)
end

function slot0.isExistsNewConfig(slot0)
	return slot0:getLatestConfigCount() ~= SignInConfig.instance:getSignInLifeTimeBonusCount()
end

function slot0.markLatestConfigCount(slot0)
	if slot0:getLatestConfigCount() ~= SignInConfig.instance:getSignInLifeTimeBonusCount() then
		slot0:setLatestConfigCount(slot1)
		slot0:dispatchRedDotEventUpdateRelateDotInfo()
	end
end

function slot0.dispatchRedDotEventUpdateRelateDotInfo(slot0)
	slot1 = RedDotEnum.DotNode.LifeCircleNewConfig

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(RedDotConfig.instance:getParentRedDotId(slot1))] = true,
		[slot1] = true
	})
end

slot0.instance = slot0.New()

return slot0
