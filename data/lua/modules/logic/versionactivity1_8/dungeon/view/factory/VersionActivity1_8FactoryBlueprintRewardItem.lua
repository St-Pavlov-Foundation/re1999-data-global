module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintRewardItem", package.seeall)

slot0 = class("VersionActivity1_8FactoryBlueprintRewardItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0.componentId = slot2

	if slot3 then
		slot0.progressPointLightGo = gohelper.findChild(slot3, "light")
	end

	slot0.actId = Activity157Model.instance:getActId()
	slot4 = {}

	if not string.nilorempty(Activity157Config.instance:getComponentReward(slot0.actId, slot0.componentId)) then
		slot4 = GameUtil.splitString2(slot5, true)
	end

	slot0._rewardItemList = {}

	for slot9, slot10 in ipairs(slot4) do
		if gohelper.findChild(slot0.go, "reward" .. slot9) then
			slot13 = slot10[1]
			slot0:getUserDataTb_().gohasget = gohelper.findChild(slot11, "#go_hasget")
			slot15, slot16 = ItemModel.instance:getItemConfigAndIcon(slot13, slot10[2])

			if slot13 == MaterialEnum.MaterialType.Building and RoomConfig.instance:getLevelGroupConfig(slot14, Activity157Config.instance:getComponentBonusBuildingLevel(slot0.actId, slot0.componentId)) then
				slot16 = ResUrl.getRoomBuildingPropIcon(slot18.icon)
			end

			slot12.simagereward = gohelper.findChildSingleImage(slot11, "#simage_reward")

			if slot16 then
				slot12.simagereward:LoadImage(slot16)
			end

			if gohelper.findChildImage(slot11, "bg") then
				UISpriteSetMgr.instance:setV1a8FactorySprite(slot17, "v1a8_dungeon_factory_rewardbg" .. slot15.rare)
			end

			gohelper.findChildText(slot11, "#txt_rewardcount").text = luaLang("multiple") .. slot10[3]

			table.insert(slot0._rewardItemList, slot12)
		end
	end

	if #slot4 < slot0.trans.childCount then
		for slot11 = slot6 + 1, slot7 do
			gohelper.setActive(slot0.trans:GetChild(slot11 - 1).gameObject, false)
		end
	end
end

function slot0.refresh(slot0, slot1)
	slot3 = Activity157Model.instance:hasComponentGotReward(slot0.componentId)

	for slot7, slot8 in ipairs(slot0._rewardItemList) do
		gohelper.setActive(slot8.gohasget, slot3)

		if slot1 and Activity157Model.instance:isRepairComponent(slot0.componentId) and not slot3 then
			slot0:playHasGetAnim(slot9)
		end
	end

	gohelper.setActive(slot0.progressPointLightGo, slot3)
end

function slot0.playHasGetAnim(slot0, slot1)
	gohelper.setActive(slot1, true)
	slot1:GetComponent(typeof(UnityEngine.Animator)):Play("go_hasget_in")
end

function slot0.destroy(slot0)
	for slot4, slot5 in pairs(slot0._rewardItemList) do
		slot5.simagereward:UnLoadImage()
	end

	slot0:__onDispose()
end

return slot0
