module("modules.logic.seasonver.act166.view.Season166MainBaseSpotItem", package.seeall)

slot0 = class("Season166MainBaseSpotItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.param = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.actId = slot0.param.actId
	slot0.baseId = slot0.param.baseId
	slot0.config = slot0.param.config
	slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	slot0.txtTitle = gohelper.findChildText(slot0.go, "txt_title")
	slot0.goStars = gohelper.findChild(slot0.go, "go_stars")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot2 = Season166Config.instance:getSeasonScoreCos(slot0.actId)
	slot0.finalLevelScore = slot2[#slot2].needScore
	slot0.starTab = slot0:getUserDataTb_()

	for slot6 = 1, 3 do
		slot7 = {
			star = gohelper.findChild(slot0.goStars, "go_star" .. slot6)
		}
		slot7.dark = gohelper.findChild(slot7.star, "dark")
		slot7.light = gohelper.findChild(slot7.star, "light")
		slot7.imageLight = gohelper.findChildImage(slot7.star, "light")
		slot7.imageLight1 = gohelper.findChildImage(slot7.star, "light/light1")

		table.insert(slot0.starTab, slot7)
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickBaseSpotItem, slot0)
end

function slot0.onClickBaseSpotItem(slot0)
	Season166Controller.instance:openSeasonBaseSpotView({
		actId = slot0.actId,
		baseId = slot0.baseId,
		config = slot0.config,
		viewType = Season166Enum.WordBaseSpotType
	})
end

function slot0.refreshUI(slot0)
	slot0.txtName.text = slot0.config.name
	slot0.txtTitle.text = string.format("St.%d", slot0.baseId)
	slot1 = Season166BaseSpotModel.instance:getStarCount(slot0.actId, slot0.baseId)

	for slot6 = 1, #slot0.starTab do
		gohelper.setActive(slot0.starTab[slot6].light, slot6 <= slot1)
		gohelper.setActive(slot0.starTab[slot6].dark, slot1 < slot6)

		slot7 = slot0.finalLevelScore <= Season166BaseSpotModel.instance:getBaseSpotMaxScore(slot0.actId, slot0.baseId) and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2"

		UISpriteSetMgr.instance:setSeason166Sprite(slot0.starTab[slot6].imageLight, slot7)
		UISpriteSetMgr.instance:setSeason166Sprite(slot0.starTab[slot6].imageLight1, slot7)
	end
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
