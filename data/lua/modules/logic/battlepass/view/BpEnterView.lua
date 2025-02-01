module("modules.logic.battlepass.view.BpEnterView", package.seeall)

slot0 = class("BpEnterView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagecover = gohelper.findChildSingleImage(slot0.viewGO, "cover/#simage_cover")
	slot0._transName = gohelper.findChildComponent(slot0.viewGO, "cover/skinname", typeof(UnityEngine.Transform))
	slot0._txtenname = gohelper.findChildText(slot0.viewGO, "cover/skinname/name/#txt_enname")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "cover/skinname/#btn_detail")
	slot0._simagedetail = gohelper.findChildSingleImage(slot0.viewGO, "cover/skinname/#btn_detail")
	slot0._headicon = gohelper.findChild(slot0.viewGO, "stamp/icon")
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_enter", AudioEnum.UI.play_ui_role_pieces_open)
	slot0._txthead = gohelper.findChildTextMesh(slot0.viewGO, "stamp/txt")
	slot0._txtheadname = gohelper.findChildTextMesh(slot0.viewGO, "stamp/name")
	slot0._addReward = gohelper.findChild(slot0.viewGO, "#go_addreward")
	slot0._gostyle1 = gohelper.findChild(slot0.viewGO, "#go_style1")
	slot0._gostyle2 = gohelper.findChild(slot0.viewGO, "#go_style2")
	slot0._gostyle3 = gohelper.findChild(slot0.viewGO, "#go_style3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnenter:AddClickListener(slot0._btnenterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnenter:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if BpConfig.instance:getBpCO(BpModel.instance.id) then
		gohelper.findChildTextMesh(slot0.viewGO, "cover/skinname").text = slot1.bpSkinDesc
		gohelper.findChildTextMesh(slot0.viewGO, "cover/skinname/name").text = slot1.bpSkinNametxt
		gohelper.findChildTextMesh(slot0.viewGO, "cover/skinname/#txt_enname").text = slot1.bpSkinEnNametxt
	end

	slot2, slot3 = BpConfig.instance:getCurHeadItemName(BpModel.instance.id)
	slot0._txtheadname.text = string.format("「%s」", slot2)

	IconMgr.instance:getCommonLiveHeadIcon(slot0._headicon):setLiveHead(slot3)

	if #BpConfig.instance:getNewItems(BpModel.instance.id) > 3 then
		logError("BP 新增道具数量错误" .. #slot5)
	elseif slot6 == 0 then
		gohelper.setActive(slot0._addReward, false)
	else
		gohelper.setActive(slot0._addReward, true)

		for slot10 = 1, 3 do
			if slot6 < slot10 then
				gohelper.setActive(gohelper.findChild(slot0._addReward, tostring(slot10)), false)
			else
				slot12 = slot5[slot10]
				slot13, slot14 = ItemModel.instance:getItemConfigAndIcon(slot12[1], slot12[2])

				gohelper.findChildSingleImage(slot11, "#simage_icon" .. slot10):LoadImage(slot14)
			end
		end
	end
end

function slot0._btndetailOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function slot0._btnenterOnClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "714",
		[StatEnum.EventProperties.RecommendPageName] = "吼吼点唱机"
	})
	BpController.instance:openBattlePassView()
end

function slot0.onDestroyView(slot0)
	slot0._simagecover:UnLoadImage()
	slot0._simagedetail:UnLoadImage()
end

return slot0
