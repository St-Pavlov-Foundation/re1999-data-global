module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2MapEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_2MapEpisodeItem", VersionActivity1_2MapEpisodeBaseItem)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)
end

function slot0.getDungeonMapLevelView(slot0)
	return ViewName.VersionActivity1_2DungeonMapLevelView
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.refreshFlag(slot0)
	gohelper.setActive(slot0._goflag, not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id))
end

function slot0._onStarItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot2
	slot5 = DungeonConfig.instance:getEpisodeAdvancedConditionText(slot4)
	slot6 = DungeonModel.instance:getEpisodeInfo(slot4)
	slot10 = nil

	if slot0:isDungeonHardModel() then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(gohelper.findChildImage(slot1, "#image_star1"), "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(gohelper.findChildImage(slot1, "#image_star2"), "juqing_xing2_kn")

		slot10 = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot7, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot8, "juqing_xing2")

		if slot3 == 1 then
			slot10 = "#e4b472"
		elseif slot3 == 2 then
			slot10 = "#e7853d"
		elseif slot3 == 3 then
			slot10 = "#ef3939"
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot7, DungeonModel.instance:hasPassLevelAndStory(slot4) and slot10 or "#949494")

	if string.nilorempty(slot5) then
		gohelper.setActive(slot8.gameObject, false)
	else
		gohelper.setActive(slot8.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot8, slot12 and slot6 and DungeonEnum.StarType.Advanced <= slot6.star and slot10 or slot11)
	end
end

function slot0.setImage(slot0, slot1, slot2, slot3)
end

function slot0.getMapCfg(slot0)
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(slot0._config.id)
end

function slot0.playAnimation(slot0, slot1)
	slot0.animator:Play(slot1, 0, 0)
end

function slot0.getEpisodeId(slot0)
	return slot0._config and slot0._config.id
end

function slot0.createStarItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.goStar = slot1
	slot2.imgStar1 = gohelper.findChildImage(slot1, "#image_star1")
	slot2.imgStar2 = gohelper.findChildImage(slot1, "#image_star2")

	return slot2
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0.goClick:RemoveClickListener()
end

return slot0
