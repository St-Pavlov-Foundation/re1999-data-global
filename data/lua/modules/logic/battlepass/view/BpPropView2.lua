module("modules.logic.battlepass.view.BpPropView2", package.seeall)

slot0 = class("BpPropView2", BaseView)

function slot0.onInitView(slot0)
	slot0._bgClick = gohelper.getClick(slot0.viewGO)
	slot0._scrollitem = gohelper.findChild(slot0.viewGO, "#scroll")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll/itemcontent")
	slot0._goeff = gohelper.findChild(slot0.viewGO, "#go_eff")
	slot0._govideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btnOK")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btnBuy")
	slot0._contentGrid = slot0._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	slot0._videoPlayer, slot0._displauUGUI = AvProMgr.instance:getVideoPlayer(slot0._govideo)

	slot0._videoPlayer:Play(slot0._displauUGUI, "videos/commonprop.mp4", true, nil, )

	slot0._scrollContent2 = gohelper.findChild(slot0.viewGO, "#scroll2/Viewport/#go_rewards")
	slot0._item = gohelper.findChild(slot0.viewGO, "#scroll2/Viewport/#go_rewards/#go_Items")
end

function slot0.addEvents(slot0)
	slot0._bgClick:AddClickListener(slot0._onClickBG, slot0)
	slot0._btnclose:AddClickListener(slot0._onClickOK, slot0)
	slot0._btnBuy:AddClickListener(slot0.openChargeView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
	slot0._bgClick:RemoveClickListener()
end

function slot0._onClickBG(slot0)
	if not slot0._openDt or UnityEngine.Time.time < slot0._openDt + 1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "关闭"
	})
	slot0:closeThis()
end

function slot0._onClickOK(slot0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "确定"
	})
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._openDt = UnityEngine.Time.time
	CommonPropListItem.hasOpen = false
	slot0._contentGrid.enabled = true

	slot0:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView2, slot0._onClickBG, slot0)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	gohelper.setActive(slot0._item, false)
	gohelper.CreateObjList(slot0, slot0._createItem, GameUtil.splitString2(BpConfig.instance:getBpCO(BpModel.instance.id).showBonus, true), slot0._scrollContent2, slot0._item)
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChild(slot1, "#go_Limit")
	slot6 = gohelper.findChild(slot1, "#go_new")
	slot9 = slot2[3]

	IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "#go_item")):setMOValue(slot2[1], slot2[2], slot9, nil, true)

	slot11 = slot9 and slot9 ~= 0

	slot10:isShowEquipAndItemCount(slot11)

	if slot11 then
		slot10:setCountText(GameUtil.numberDisplay(slot9))
	end

	slot10:setCountFontSize(43)
	gohelper.setActive(slot4, slot2[4] == 1)
	gohelper.setActive(slot6, slot2[5] == 1)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._setPropItems(slot0)
	CommonPropListModel.instance:setPropList(slot0.viewParam)

	for slot5, slot6 in ipairs(CommonPropListModel.instance:getList()) do
		slot7 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gocontent, "cell" .. slot5)

		transformhelper.setLocalScale(slot7.transform, 0.7, 0.7, 0.7)

		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, CommonPropListItem)
		slot8._index = slot5
		slot8._view = slot0

		slot8:onUpdateMO(slot6)

		function slot8.callback()
			uv0:setCountFontSize(43)
		end
	end

	recthelper.setHeight(slot0._gocontent.transform, math.ceil(#slot1 / 6) * 182)

	if #slot1 <= 6 then
		transformhelper.setLocalPosXY(slot0._scrollitem.transform, 0, 169)
	end
end

function slot0.openChargeView(slot0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "解锁吼吼典藏光碟"
	})
	ViewMgr.instance:openView(ViewName.BpChargeView)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function slot0.onDestroyView(slot0)
	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
