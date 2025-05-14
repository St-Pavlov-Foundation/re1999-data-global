module("modules.logic.help.view.HelpVersionActivityContentItem", package.seeall)

local var_0_0 = class("HelpVersionActivityContentItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1.go
	arg_2_0._config = arg_2_1.config
	arg_2_0._index = arg_2_1.index
	arg_2_0._txtObj = gohelper.findChild(arg_2_0._go, "txtobj")
	arg_2_0._imgObj = gohelper.findChild(arg_2_0._go, "imgobj")
	arg_2_0._gocontentRoot = gohelper.findChild(arg_2_0._go, "imgobj/#go_content")
	arg_2_0._btnquit = gohelper.findChildButtonWithAudio(arg_2_0._imgObj, "#btn_quit")

	arg_2_0._btnquit:AddClickListener(arg_2_0._btnquitOnClick, arg_2_0)
	gohelper.addUIClickAudio(arg_2_0._btnquit.gameObject, AudioEnum.UI.UI_help_close)
	transformhelper.setLocalPos(arg_2_0._go.transform, arg_2_1.pos, 0, 0)

	if not string.nilorempty(arg_2_0._config.icon) then
		arg_2_0._conImg = gohelper.findChildSingleImage(arg_2_0._imgObj, "img")

		arg_2_0:setImageContent()
	elseif not string.nilorempty(arg_2_0._config.text) then
		arg_2_0._conGameObject = gohelper.findChild(arg_2_0._txtObj, "#scroll_desc/viewport/content/desctxt")

		gohelper.setActive(arg_2_0._conGameObject, false)

		arg_2_0._titleTxt = SLFramework.GameObjectHelper.FindChildComponent(arg_2_0._txtObj, "titletxt", typeof(TMPro.TextMeshProUGUI))
		arg_2_0._conTexts = {}

		arg_2_0:setTextContent()
	end
end

function var_0_0.updatePos(arg_3_0, arg_3_1)
	transformhelper.setLocalPos(arg_3_0._go.transform, arg_3_1, 0, 0)
end

function var_0_0._btnquitOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.HelpView)
end

function var_0_0.setImageContent(arg_5_0)
	gohelper.setActive(arg_5_0._imgObj, true)
	gohelper.setActive(arg_5_0._txtObj, false)
	arg_5_0._conImg:LoadImage(ResUrl.getVersionActivityHelpItem(arg_5_0._config.icon, arg_5_0._config.isCn == 1))

	if not string.nilorempty(arg_5_0._config.iconText) then
		local var_5_0 = string.format("ui/viewres/help/versionactivityimgcontent/%s.prefab", arg_5_0._config.iconText)

		arg_5_0._resLoader = PrefabInstantiate.Create(arg_5_0._gocontentRoot)

		arg_5_0._resLoader:startLoad(var_5_0, arg_5_0._onHelpImgLoaded, arg_5_0)
	end
end

function var_0_0._onHelpImgLoaded(arg_6_0)
	arg_6_0._imgPrefGo = arg_6_0._resLoader:getInstGO()

	gohelper.setActive(arg_6_0._imgPrefGo, true)

	if arg_6_0._config.icon == "va_1_1_season_3" then
		local var_6_0 = gohelper.findChildTextMesh(arg_6_0._imgPrefGo, "Text1/Text2")
		local var_6_1 = luaLang("p_vahelpcontentitem_season3_7")

		var_6_0.text = ServerTime.ReplaceUTCStr(var_6_1)
	end

	if arg_6_0._config.id == 1610105 then
		local var_6_2 = gohelper.findChildTextMesh(arg_6_0._imgPrefGo, "Text3")
		local var_6_3 = ActivityModel.instance:getActMO(VersionActivity1_6Enum.ActivityId.DungeonBossRush)
		local var_6_4 = var_6_3 and 3 - var_6_3:getOpeningDay() % 3 or 3

		var_6_2.text = string.format(luaLang("p_v1a6_activityboss_help_3_txt_3"), var_6_4)
	end
end

function var_0_0.setTextContent(arg_7_0)
	gohelper.setActive(arg_7_0._imgObj, false)
	gohelper.setActive(arg_7_0._txtObj, true)

	arg_7_0._titleTxt.text = arg_7_0._config.title

	local var_7_0 = string.split(arg_7_0._config.text, "\n")

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = arg_7_0._conTexts[iter_7_0]

		if not var_7_1 then
			var_7_1 = gohelper.cloneInPlace(arg_7_0._conGameObject, "item" .. iter_7_0):GetComponent(typeof(TMPro.TextMeshProUGUI))

			table.insert(arg_7_0._conTexts, var_7_1)
		end

		local var_7_2 = var_7_0[iter_7_0]
		local var_7_3 = luaLang("HelpVersionActivityContentItem_lefttag")

		if GameUtil.utf8sub(var_7_2, 1, 1) == var_7_3 then
			local var_7_4 = luaLang("HelpVersionActivityContentItem_righttag")

			var_7_2 = string.gsub(var_7_2, var_7_3, "<line-height=108%%><size=32><color=#323c34><alpha=#FF>" .. var_7_3, 1)
			var_7_2 = string.gsub(var_7_2, var_7_4, var_7_4 .. "</size></color>\n<line-height=100%%><margin=14>", 1)
		else
			var_7_2 = "<margin=14><alpha=#BF>" .. var_7_2
		end

		var_7_1.text = var_7_2

		gohelper.setActive(var_7_1.gameObject, true)
	end

	for iter_7_1 = #var_7_0 + 1, #arg_7_0._conTexts do
		gohelper.setActive(arg_7_0._conTexts[iter_7_1], false)
	end
end

function var_0_0.showQuitBtn(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._btnquit.gameObject, arg_8_1)
end

function var_0_0.updateItem(arg_9_0)
	return
end

function var_0_0.addEventListeners(arg_10_0)
	return
end

function var_0_0.removeEventListeners(arg_11_0)
	return
end

function var_0_0.onStart(arg_12_0)
	return
end

function var_0_0.destroy(arg_13_0)
	if arg_13_0._conImg then
		arg_13_0._conImg:UnLoadImage()

		arg_13_0._conImg = nil
	end

	if arg_13_0._resloader then
		arg_13_0._resloader:dispose()

		arg_13_0._resloader = nil
	end

	arg_13_0._btnquit:RemoveClickListener()
end

return var_0_0
