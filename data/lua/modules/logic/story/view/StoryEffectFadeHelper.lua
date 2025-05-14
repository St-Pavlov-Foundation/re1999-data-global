module("modules.logic.story.view.StoryEffectFadeHelper", package.seeall)

local var_0_0 = class("StoryEffectFadeHelper")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._initRenderAlphas = {}
	arg_1_0._renderGos = {}

	local var_1_0 = arg_1_0._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for iter_1_0 = 0, var_1_0.Length - 1 do
		local var_1_1 = var_1_0[iter_1_0].gameObject.name

		if not string.nilorempty(var_1_1) then
			table.insert(arg_1_0._renderGos, var_1_0[iter_1_0].gameObject)
		end
	end

	local var_1_2 = arg_1_0._go.transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for iter_1_1 = 0, var_1_2.Length - 1 do
		local var_1_3 = var_1_2[iter_1_1].gameObject.name

		if not string.nilorempty(var_1_3) then
			table.insert(arg_1_0._renderGos, var_1_2[iter_1_1].gameObject)
		end
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_0._renderGos) do
		local var_1_4 = iter_1_3:GetComponent(typeof(UnityEngine.Renderer))

		if var_1_4 then
			local var_1_5 = var_1_4.sharedMaterials

			for iter_1_4 = 0, var_1_5.Length - 1 do
				local var_1_6 = var_1_5[iter_1_4]

				if not gohelper.isNil(var_1_6) and var_1_6:HasProperty("_MainColor") then
					local var_1_7 = var_1_6:GetColor("_MainColor")

					arg_1_0._initRenderAlphas[iter_1_3.name .. "_" .. var_1_6.name] = {
						var_1_7.r,
						var_1_7.g,
						var_1_7.b,
						var_1_7.a
					}
				end
			end
		end
	end
end

function var_0_0.setTransparency(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._renderGos) do
		local var_2_0 = iter_2_1:GetComponent(typeof(UnityEngine.Renderer))

		if var_2_0 then
			local var_2_1 = var_2_0.sharedMaterials

			for iter_2_2 = 0, var_2_1.Length - 1 do
				local var_2_2 = var_2_1[iter_2_2]

				if not gohelper.isNil(var_2_2) and var_2_2:HasProperty("_MainColor") and arg_2_0._initRenderAlphas[iter_2_1.name .. "_" .. var_2_2.name] then
					local var_2_3 = var_2_2:GetColor("_MainColor")

					var_2_3.a = arg_2_1 * arg_2_0._initRenderAlphas[iter_2_1.name .. "_" .. var_2_2.name][4]

					var_2_2:SetColor("_MainColor", var_2_3)
				end
			end
		end
	end
end

function var_0_0.setEffectLoop(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._go.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for iter_3_0 = 0, var_3_0.Length - 1 do
		var_3_0[iter_3_0].main.loop = arg_3_1
	end
end

function var_0_0.destroy(arg_4_0)
	if not arg_4_0._go or not arg_4_0._go.transform then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._renderGos) do
		local var_4_0 = iter_4_1:GetComponent(typeof(UnityEngine.Renderer))

		if var_4_0 then
			local var_4_1 = var_4_0.sharedMaterials

			for iter_4_2 = 0, var_4_1.Length - 1 do
				local var_4_2 = var_4_1[iter_4_2]

				if not gohelper.isNil(var_4_2) and var_4_2:HasProperty("_MainColor") and arg_4_0._initRenderAlphas[iter_4_1.name .. "_" .. var_4_2.name] then
					local var_4_3 = var_4_2:GetColor("_MainColor")

					var_4_3.a = arg_4_0._initRenderAlphas[iter_4_1.name .. "_" .. var_4_2.name][4]

					var_4_2:SetColor("_MainColor", var_4_3)
				end
			end
		end
	end

	arg_4_0._initRenderAlphas = nil
	arg_4_0._renderGos = nil
end

return var_0_0
