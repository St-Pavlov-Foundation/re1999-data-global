module("modules.logic.dungeon.view.DungeonEquipEntryItem", package.seeall)

slot0 = class("DungeonEquipEntryItem", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "coverInfo/title/#txt_title")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "coverInfo/title/#txt_titleEn")
	slot0._simagecoverpic = gohelper.findChildSingleImage(slot0.viewGO, "coverInfo/#simage_coverpic")
	slot0._txtcoverDesc = gohelper.findChildText(slot0.viewGO, "coverInfo/#txt_coverDesc")
	slot0._imagefill = gohelper.findChildImage(slot0.viewGO, "coverInfo/progress/#image_fill")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "coverInfo/progress/#txt_progress")
	slot0._txttype = gohelper.findChildText(slot0.viewGO, "detailInfo/clue/#txt_type")
	slot0._txttypeNameEn = gohelper.findChildText(slot0.viewGO, "detailInfo/clue/#txt_type/#txt_typeNameEn")
	slot0._txtclueName = gohelper.findChildText(slot0.viewGO, "detailInfo/clue/#txt_clueName")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "detailInfo/clue/#simage_pic")
	slot0._txtclueDesc = gohelper.findChildText(slot0.viewGO, "detailInfo/desc/#txt_clueDesc")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "detailInfo/#go_reward")
	slot0._gocomplate = gohelper.findChild(slot0.viewGO, "detailInfo/#go_complate")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "detailInfo/#go_reward/#scroll_reward")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "detailInfo/#go_reward/#scroll_reward/#btn_reward")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "detailInfo/#go_reward/#scroll_reward/Viewport/Content/#go_item")
	slot0._btnsurveybtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "detailInfo/#go_reward/#btn_surveybtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsurveybtn:AddClickListener(slot0._btnsurveybtnOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsurveybtn:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnsurveybtnOnClick(slot0)
	DungeonFightController.instance:enterFight(slot0._config.chapterId, slot0._episodeId)
end

function slot0._btnrewardOnClick(slot0)
	DungeonController.instance:openDungeonRewardView(slot0._config)
end

function slot0._editableInitView(slot0)
	slot0._config = DungeonConfig.instance:getEpisodeCO(slot0._episodeId)

	slot0._simagebg1:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_diban"))
	slot0._simagebg2:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_zhuangshi"))

	slot0._txttitle.text = slot0._config.name
	slot0._txttitleEn.text = slot0._config.name_En
	slot0._txtclueDesc.text = string.format("          %s", slot0._config.battleDesc)
	slot0._txtcoverDesc.text = slot0._config.desc
	slot0._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_map_sp_equip_progress"), {
		slot0._progress - 1,
		slot0._episodeNum
	})
	slot0._imagefill.fillAmount = (slot0._progress - 1) / slot0._episodeNum
	slot3 = DungeonModel.instance:hasPassLevel(slot0._episodeId) and DungeonModel.instance:getEpisodeInfo(slot0._episodeId).challengeCount == 1

	gohelper.setActive(slot0._goreward, not slot3)
	gohelper.setActive(slot0._gocomplate, slot3)

	slot4 = slot0._config.navigationpic

	slot0._simagecoverpic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", slot4, 1)))
	slot0._simagepic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", slot4, 2)))

	for slot9, slot10 in ipairs(DungeonModel.instance:getEpisodeRewardDisplayList(slot0._episodeId)) do
		slot11 = gohelper.cloneInPlace(slot0._goitem)

		gohelper.setActive(slot11, true)

		slot12 = IconMgr.instance:getCommonPropItemIcon(slot11)

		slot12:setMOValue(slot10[1], slot10[2], slot10[3])
		slot12:isShowEquipAndItemCount(false)
		slot12:hideEquipLvAndBreak(true)
	end
end

function slot0.ctor(slot0, slot1)
	slot0._episodeIndex = slot1[1]
	slot0._episodeNum = slot1[2]
	slot0._episodeId = slot1[3]
	slot0._progress = slot1[4]
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroy(slot0)
	slot0:removeEvents()
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simagecoverpic:UnLoadImage()
	slot0._simagepic:UnLoadImage()
end

return slot0
