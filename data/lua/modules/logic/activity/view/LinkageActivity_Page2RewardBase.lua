module("modules.logic.activity.view.LinkageActivity_Page2RewardBase", package.seeall)

slot0 = class("LinkageActivity_Page2RewardBase", RougeSimpleItemBase)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	uv0.super.ctor(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0.actId(slot0)
	return slot0:_assetGetParent():actId()
end

function slot0.isType101RewardCouldGetAnyOne(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:actId())
end

function slot0.isType101RewardGet(slot0)
	return ActivityType101Model.instance:isType101RewardGet(slot0:actId(), slot0._index)
end

function slot0.isType101RewardCouldGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0:actId(), slot0._index)
end

function slot0.getType101LoginCount(slot0)
	return ActivityType101Model.instance:getType101LoginCount(slot0:actId())
end

function slot0.getNorSignActivityCo(slot0)
	return ActivityConfig.instance:getNorSignActivityCo(slot0:actId(), slot0._index)
end

function slot0.sendGet101BonusRequest(slot0, slot1, slot2)
	return Activity101Rpc.instance:sendGet101BonusRequest(slot0:actId(), slot0._index, slot1, slot2)
end

function slot0.claimAll(slot0, slot1, slot2)
	return ActivityType101Model.instance:claimAll(slot0:actId(), slot1, slot2)
end

function slot0.isActOnLine(slot0)
	return ActivityModel.instance:isActOnLine(slot0:actId())
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:isShowQuality(false)
	slot1:customOnClickCallback(function ()
		if not uv0:isActOnLine() then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if uv0:isType101RewardCouldGet() then
			uv0:claimAll(uv0._onClaimAllCb, uv0)

			return
		end

		MaterialTipController.instance:showMaterialInfo(uv1[1], uv1[2])
	end)
end

return slot0
