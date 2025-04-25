module("modules.logic.lifecircle.view.LifeCircleSignRewardsItem", package.seeall)

slot0 = class("LifeCircleSignRewardsItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._gorewardtemplate = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_reward_template")
	slot0._goimagestatus = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_image_status")
	slot0._goimagestatuslight = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_image_status_light")
	slot0._goimportant = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_important")
	slot0._txtpointvalue = gohelper.findChildText(slot0.viewGO, "#go_rewards/#go_important/#txt_pointvalue")
	slot0._txtpointvalue_normal = gohelper.findChildText(slot0.viewGO, "#go_rewards/#txt_pointvalue_normal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = string.splitToNumber
slot2 = string.split

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)

	slot0._rewardItemList = {}
	slot0._isLastOne = false
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_rewardItemList")
	slot0:__onDispose()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorewardtemplate, false)
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)

	slot0._isLastOne = string.nilorempty(slot0._mo.bonus)
	slot6 = slot0:isClaimable() or slot0:isClaimed()
	slot8 = slot0._isLastOne and 2 or #(slot0._isLastOne and {} or uv1(slot3, "|"))

	for slot12 = 1, slot8 do
		slot13 = nil
		slot14 = not slot0._isLastOne and uv2(slot7[slot12], "#") or nil

		if slot12 > #slot0._rewardItemList then
			table.insert(slot0._rewardItemList, slot0:_create_LifeCircleSignRewardsItemItem(slot12))
		else
			slot13 = slot0._rewardItemList[slot12]
		end

		slot13:onUpdateMO(slot14)
		slot13:setActive(true)
	end

	for slot12 = slot8 + 1, #slot0._rewardItemList do
		slot0._rewardItemList[slot12]:setActive(false)
	end

	slot0._txtpointvalue.text = slot0:logindaysid()
	slot0._txtpointvalue_normal.text = slot0._isLastOne and luaLang("LifeCircleSignRewardsItemItemLastOnePtValue") or slot4 and "" or slot0:logindaysid()

	gohelper.setActive(slot0._goimportant, slot4)
	gohelper.setActive(slot0._goimagestatus, not slot6)
	gohelper.setActive(slot0._goimagestatuslight, slot6)
end

function slot0.isLastOne(slot0)
	return slot0._isLastOne
end

function slot0.stageid(slot0)
	return slot0._mo.stageid
end

function slot0.logindaysid(slot0)
	return slot0._mo.logindaysid
end

function slot0._create_LifeCircleSignRewardsItemItem(slot0, slot1)
	slot3 = LifeCircleSignRewardsItemItem.New({
		parent = slot0,
		baseViewContainer = slot0:baseViewContainer()
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._gorewardtemplate))

	return slot3
end

function slot0._totalLoginDays(slot0)
	return slot0:parent():totalLoginDays()
end

function slot0.onItemClick(slot0)
	if slot0:isClaimable() then
		LifeCircleController.instance:sendSignInTotalRewardRequest(slot0:stageid())

		return false
	end

	return true
end

function slot0.isClaimed(slot0)
	if slot0._isLastOne then
		return false
	end

	return SignInModel.instance:isClaimedAccumulateReward(slot0:stageid())
end

function slot0.isClaimable(slot0)
	if slot0._isLastOne then
		return false
	end

	return LifeCircleController.instance:isClaimableAccumulateReward(slot0:stageid())
end

return slot0
