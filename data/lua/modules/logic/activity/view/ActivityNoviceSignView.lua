module("modules.logic.activity.view.ActivityNoviceSignView", package.seeall)

slot0 = class("ActivityNoviceSignView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageframebg = gohelper.findChildSingleImage(slot0.viewGO, "character/image_frame")
	slot0._simagecharacter = gohelper.findChildSingleImage(slot0.viewGO, "character/image_character")
	slot0._godaylist = gohelper.findChild(slot0.viewGO, "#go_daylist")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_daylist/#scroll_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "activitydesc/tips/#txt_desc")
	slot0._txtreward = gohelper.findChildText(slot0.viewGO, "activitydesc/tips/#txt_reward")
	slot0._gostarlist = gohelper.findChild(slot0.viewGO, "activitydesc/tips/#go_starlist")
	slot0._gostaricon = gohelper.findChild(slot0.viewGO, "activitydesc/tips/#go_starlist/#go_staricon")
	slot0._actId = ActivityEnum.Activity.NoviceSign

	Activity101Rpc.instance:sendGet101InfosRequest(slot0._actId)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_bg"))
	slot0._simageframebg:LoadImage(ResUrl.getActivityBg("eightday/img_lihui_deco_fire"))
	slot0._simagecharacter:LoadImage(ResUrl.getActivityBg("eightday/char_008"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
end

function slot0._refresh(slot0)
	slot1 = {}

	for slot5 = 1, 8 do
		table.insert(slot1, {
			data = ActivityConfig.instance:getNorSignActivityCo(slot0._actId, slot5)
		})
	end

	ActivityNoviceSignItemListModel.instance:setDayList(slot1)

	slot3 = string.splitToNumber(slot1[8].data.bonus, "#")
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot3[1], slot3[2])

	if slot3[1] == MaterialEnum.MaterialType.Hero then
		if GameConfig:GetCurLangType() == LangSettings.jp then
			gohelper.setActive(slot0._gostarlist, false)

			slot0._txtdesc.text = string.format(ActivityConfig.instance:getActivityCo(slot0._actId).actDesc, string.rep("<sprite=0>", 5) .. string.format("%s<color=#c66030>%s</color>", luaLang("activitynovicesign_character"), slot4.name))
			slot0._txtreward.text = ""
		else
			gohelper.setActive(slot0._gostarlist, true)

			slot0._txtdesc.text = string.format("%s", slot2.actDesc)
			slot0._txtreward.text = string.format(GameConfig:GetCurLangType() == LangSettings.zh and "%s<color=#c66030>%s</color>。" or "%s<color=#c66030> %s</color>.", luaLang("activitynovicesign_character"), slot4.name)

			if not slot0._hasCreateStar then
				for slot10 = 1, 4 do
					gohelper.cloneInPlace(slot0._gostaricon, "star" .. slot10)
				end

				slot0._hasCreateStar = true
			end
		end
	else
		gohelper.setActive(slot0._gostarlist, false)

		slot0._txtdesc.text = string.format("%s", slot2.actDesc)
		slot0._txtreward.text = string.format("<color=#c66030>%s</color>", slot4.name)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageframebg:UnLoadImage()
	slot0._simagecharacter:UnLoadImage()
end

return slot0
