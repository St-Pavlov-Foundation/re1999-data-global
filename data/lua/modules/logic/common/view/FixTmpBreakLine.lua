module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

local var_0_0 = class("FixTmpBreakLine", LuaCompBase)
local var_0_1 = typeof(ZProj.LangFont)
local var_0_2 = {
	"en",
	"de",
	"fr",
	"thai"
}

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0.textMeshPro = arg_1_1.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if arg_1_0.textMeshPro then
		arg_1_0.textMeshPro.richText = true
	end
end

function var_0_0.refreshTmpContent(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(var_0_2) do
		if GameConfig:GetCurLangShortcut() == iter_2_1 then
			return
		end
	end

	if not arg_2_1 then
		return
	end

	arg_2_0:initData(arg_2_1)

	local var_2_0 = arg_2_0.textMeshPro.text

	if not arg_2_0:startsWith(var_2_0, "<nobr>") then
		var_2_0 = string.format("<nobr>%s", var_2_0)
	end

	GameGlobalMgr.instance:getLangFont():refreshFontAsset(arg_2_0.textMeshPro)

	local var_2_1 = arg_2_0:replaceContent(var_2_0)

	arg_2_0.textMeshPro.text = var_2_1

	arg_2_0.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function var_0_0.replaceContent(arg_3_0, arg_3_1)
	local var_3_0 = 0
	local var_3_1 = ""
	local var_3_2 = ""
	local var_3_3 = false

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_4 = string.sub(arg_3_1, iter_3_0, iter_3_0)

		if var_3_4 == "<" then
			var_3_3 = true
		elseif var_3_4 == ">" then
			var_3_3 = false
		end

		if not var_3_3 and var_3_4 == " " then
			var_3_0 = var_3_0 + 1
		else
			if var_3_0 > 0 then
				var_3_1 = var_3_1 .. "<space=" .. var_3_0 * ZProj.GameHelper.GetTmpCharWidth(arg_3_0.textMeshPro, 32) .. ">"
				var_3_0 = 0
			end

			var_3_1 = var_3_1 .. var_3_4
		end
	end

	return var_3_1
end

function var_0_0.startsWith(arg_4_0, arg_4_1, arg_4_2)
	return string.sub(arg_4_1, 1, string.len(arg_4_2)) == arg_4_2
end

return var_0_0
