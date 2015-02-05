module Attrocity
  class ModuleBuilder < Module

    def included(mod)
      mod.extend(Attrocity::ModuleMethods)
      mod.extend(ModuleHooks)
    end

    module ModuleHooks
      def extend_object(obj)
        self.attribute_set.attributes.each do |mod_attr|
          obj.attribute_set << mod_attr
        end
        Attrocity.perform_attributes_actions(obj)
      end
    end

  end
end
