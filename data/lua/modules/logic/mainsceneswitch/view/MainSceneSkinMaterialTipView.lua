module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView", package.seeall)

slot0 = class("MainSceneSkinMaterialTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._gobannerContent = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent")
	slot0._goroominfoItem = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	slot0._goSceneLogo = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag")
	slot0._gobannerscroll = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerscroll")
	slot0._gobuyContent = gohelper.findChild(slot0.viewGO, "right/#go_buyContent")
	slot0._goblockInfoItem = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	slot0._gopay = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_pay")
	slot0._gopayitem = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	slot0._gochange = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_change")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	slot0._btninsight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	slot0._txtcostnum = gohelper.findChildText(slot0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	slot0._gosource = gohelper.findChild(slot0.viewGO, "right/#go_source")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "right/#go_source/title/#txt_time")
	slot0._scrolljump = gohelper.findChildScrollRect(slot0.viewGO, "right/#go_source/#scroll_jump")
	slot0._gojumpItem = gohelper.findChild(slot0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninsight:AddClickListener(slot0._btninsightOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninsight:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btninsightOnClick(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gojumpItem, false)
	gohelper.setActive(slot0._gobuyContent, false)
	gohelper.setActive(slot0._gosource, true)

	slot0._jumpParentGo = gohelper.findChild(slot0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	slot0.jumpItemGos = {}

	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0._refreshUI(slot0)
	slot0._canJump = slot0.viewParam.canJump
	slot0._config = ItemModel.instance:getItemConfig(slot0.viewParam.type, slot0.viewParam.id)
	slot0._sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(slot0.viewParam.id)

	slot0:_cloneJumpItem()
end

function slot0._cloneJumpItem(slot0)
	slot0._scrolljump.verticalNormalizedPosition = 1
	slot1 = {}

	if slot0._config then
		slot1 = slot0:_sourcesStrToTables(slot0._config.sources)
	end

	for slot5 = 1, #slot1 do
		if not slot0.jumpItemGos[slot5] then
			slot7 = slot5 == 1 and slot0._gojumpItem or gohelper.clone(slot0._gojumpItem, slot0._jumpParentGo, "item" .. slot5)
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot7
			slot6.originText = gohelper.findChildText(slot7, "frame/txt_chapter")
			slot6.indexText = gohelper.findChildText(slot7, "frame/txt_name")
			slot6.jumpBtn = gohelper.findChildButtonWithAudio(slot7, "frame/btn_jump")
			slot6.jumpBgGO = gohelper.findChild(slot7, "frame/btn_jump/jumpbg")

			table.insert(slot0.jumpItemGos, slot6)
			slot6.jumpBtn:AddClickListener(function (slot0)
				if slot0.cantJumpTips then
					GameFacade.showToastWithTableParam(slot0.cantJumpTips, slot0.cantJumpParam)
				elseif slot0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					uv0:checkViewOpenAndClose()
					GameFacade.jump(slot0.jumpId, uv0._onJumpFinish, uv0, uv0.viewParam.recordFarmItem)
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, slot6)
		end

		slot7 = slot1[slot5]
		slot6.canJump = slot0._canJump
		slot6.jumpId = slot7.sourceId
		slot8, slot9 = JumpConfig.instance:getJumpName(slot7.sourceId)
		slot6.originText.text = slot8 or ""
		slot6.indexText.text = slot9 or ""
		slot10, slot6.cantJumpParam = slot0:_getCantJump(slot7)

		ZProj.UGUIHelper.SetGrayscale(slot6.jumpBgGO, slot10 ~= nil)

		slot6.cantJumpTips = slot10

		gohelper.setActive(slot6.go, true)
		gohelper.setActive(slot6.jumpBtn, not JumpController.instance:isOnlyShowJump(slot7.sourceId))
	end

	gohelper.setActive(slot0._gosource, #slot1 > 0)

	for slot5 = #slot1 + 1, #slot0.jumpItemGos do
		gohelper.setActive(slot0.jumpItemGos[slot5].go, false)
	end
end

function slot0._sourcesStrToTables(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		for slot7, slot8 in ipairs(string.split(slot1, "|")) do
			slot9 = string.splitToNumber(slot8, "#")
			slot10 = {
				sourceId = slot9[1],
				probability = slot9[2]
			}
			slot10.episodeId = JumpConfig.instance:getJumpEpisodeId(slot10.sourceId)

			if slot10.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(slot10.episodeId) then
				table.insert(slot2, slot10)
			end
		end
	end

	return slot2
end

function slot0._getCantJump(slot0, slot1)
	slot3, slot4 = nil

	if not JumpController.instance:isJumpOpen(slot1.sourceId) then
		slot3, slot4 = OpenHelper.getToastIdAndParam(JumpConfig.instance:getJumpConfig(slot1.sourceId).openId)
	else
		slot3, slot4 = JumpController.instance:cantJump(slot5.param)
	end

	return slot3, slot4
end

slot0.NeedCloseView = {
	ViewName.PackageStoreGoodsView
}

function slot0.checkViewOpenAndClose(slot0)
	for slot4, slot5 in pairs(uv0.NeedCloseView) do
		if ViewMgr.instance:isOpen(slot5) then
			ViewMgr.instance:closeView(slot5)
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	for slot4 = 1, #slot0.jumpItemGos do
		slot0.jumpItemGos[slot4].jumpBtn:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
