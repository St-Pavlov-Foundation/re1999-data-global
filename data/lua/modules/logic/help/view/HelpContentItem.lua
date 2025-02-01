module("modules.logic.help.view.HelpContentItem", package.seeall)

slot0 = class("HelpContentItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
end

function slot0.init(slot0, slot1)
	slot0._go = slot1.go
	slot0._config = slot1.config
	slot0._index = slot1.index
	slot0._txtObj = gohelper.findChild(slot0._go, "txtobj")
	slot0._imgObj = gohelper.findChild(slot0._go, "imgobj")
	slot0._gocontentRoot = gohelper.findChild(slot0._go, "imgobj/#go_content")
	slot0._btnquit = gohelper.findChildButtonWithAudio(slot0._imgObj, "#btn_quit")

	slot0._btnquit:AddClickListener(slot0._btnquitOnClick, slot0)
	gohelper.addUIClickAudio(slot0._btnquit.gameObject, AudioEnum.UI.UI_help_close)
	transformhelper.setLocalPos(slot0._go.transform, slot1.pos, 0, 0)

	if not string.nilorempty(slot0._config.icon) then
		slot0._conImg = gohelper.findChildSingleImage(slot0._imgObj, "img")

		slot0:setImageContent()
	elseif not string.nilorempty(slot0._config.text) then
		slot0._conGameObject = gohelper.findChild(slot0._txtObj, "#scroll_desc/viewport/content/desctxt")

		gohelper.setActive(slot0._conGameObject, false)

		slot0._titleTxt = SLFramework.GameObjectHelper.FindChildComponent(slot0._txtObj, "titletxt", typeof(TMPro.TextMeshProUGUI))
		slot0._conTexts = {}

		slot0:setTextContent()
	end
end

function slot0.updatePos(slot0, slot1)
	transformhelper.setLocalPos(slot0._go.transform, slot1, 0, 0)
end

function slot0._btnquitOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.HelpView)
end

function slot0.setImageContent(slot0)
	gohelper.setActive(slot0._imgObj, true)
	gohelper.setActive(slot0._txtObj, false)

	if slot0._config.icon == "empty" then
		slot0._conImg:UnLoadImage()
	else
		slot0._conImg:LoadImage(ResUrl.getHelpItem(slot0._config.icon, slot0._config.isCn == 1))
	end

	if not string.nilorempty(slot0._config.iconText) then
		slot0._resLoader = PrefabInstantiate.Create(slot0._gocontentRoot)

		slot0._resLoader:startLoad(string.format("ui/viewres/help/imgcontent/%s.prefab", slot0._config.iconText), slot0._onHelpImgLoaded, slot0)
	end
end

function slot0._onHelpImgLoaded(slot0)
	slot0._imgPrefGo = slot0._resLoader:getInstGO()

	gohelper.setActive(slot0._imgPrefGo, true)

	if slot0._config.iconText == "50110" then
		gohelper.findChildTextMesh(slot0._imgPrefGo, "#text_rule").text = string.gsub(luaLang("p_helpcontentitem_50110_7"), "UTC%+8", ServerTime.GetUTCOffsetStr())
	end

	if slot0._config.icon == "va_1_1_season_3" then
		gohelper.findChildTextMesh(slot0._imgPrefGo, "Text1/Text2").text = ServerTime.ReplaceUTCStr(luaLang("p_vahelpcontentitem_season3_7"))
	end
end

function slot0.setTextContent(slot0)
	gohelper.setActive(slot0._imgObj, false)
	gohelper.setActive(slot0._txtObj, true)

	slot0._titleTxt.text = slot0._config.title

	for slot5 = 1, #string.split(slot0._config.text, "\n") do
		if not slot0._conTexts[slot5] then
			table.insert(slot0._conTexts, gohelper.cloneInPlace(slot0._conGameObject, "item" .. slot5):GetComponent(typeof(TMPro.TextMeshProUGUI)))
		end

		if GameUtil.utf8sub(slot1[slot5], 1, 1) == luaLang("helpcontentitem_lefttag") then
			slot9 = luaLang("helpcontentitem_righttag")
			slot7 = string.gsub(string.gsub(slot7, slot8, "<line-height=108%%><size=32><color=#323c34><alpha=#FF>" .. slot8, 1), slot9, slot9 .. "</size></color>\n<line-height=100%%><margin=14>", 1)
		else
			slot7 = "<margin=14><alpha=#BF>" .. slot7
		end

		slot6.text = slot7

		gohelper.setActive(slot6.gameObject, true)
	end

	for slot5 = #slot1 + 1, #slot0._conTexts do
		gohelper.setActive(slot0._conTexts[slot5], false)
	end
end

function slot0.showQuitBtn(slot0, slot1)
	gohelper.setActive(slot0._btnquit.gameObject, slot1)
end

function slot0.updateItem(slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
end

function slot0.destroy(slot0)
	if slot0._conImg then
		slot0._conImg:UnLoadImage()

		slot0._conImg = nil
	end

	if slot0._resloader then
		slot0._resloader:dispose()

		slot0._resloader = nil
	end

	slot0._btnquit:RemoveClickListener()
end

return slot0
