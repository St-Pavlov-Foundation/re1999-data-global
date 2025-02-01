module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandView", package.seeall)

slot0 = class("VersionActivity1_3FairyLandView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_bg")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_bg2")
	slot0._imagetitle = gohelper.findChildImage(slot0.viewGO, "root/#image_title")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_confirm")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/#go_content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if not slot0._useDreamCard then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), slot0._selectedItem.config.id)
	end

	if slot0._selectedItem then
		Activity126Controller.instance:dispatchEvent(Activity126Event.selectDreamLandCard, slot0._selectedItem.config)
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg"))
	slot0._simagebg2:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg2"))
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function slot0._initItems(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(lua_activity126_dreamland_card.configList) do
		if slot0:_hasDreamCard(slot6.id) then
			table.insert(slot0._itemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent), VersionActivity1_3FairyLandItem, {
				slot0,
				slot6
			}))
		end
	end

	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot6.config == slot0._cardConfig then
			slot0:landItemClick(slot6)

			break
		end
	end
end

function slot0._hasDreamCard(slot0, slot1)
	if slot0._taskConfig and slot0._useDreamCard then
		return string.find(slot0._taskConfig.dreamCards, slot1)
	end

	return Activity126Model.instance:hasDreamCard(slot1)
end

function slot0.landItemClick(slot0, slot1)
	slot0._selectedItem = slot1

	for slot5, slot6 in ipairs(slot0._itemList) do
		slot6:setSelected(slot6 == slot1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._taskConfig = slot0.viewParam[1]
	slot0._cardConfig = slot0.viewParam[2]
	slot0._useDreamCard = not string.nilorempty(slot0._taskConfig.dreamCards)

	slot0:_initItems()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
