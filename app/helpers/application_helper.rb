module ApplicationHelper
  def l(obj)
    if obj.respond_to? 'path'
      link_to(obj,obj.path)
    else
      link_to(obj,obj)
    end
  end

  def header
    render :partial => 'header'
  end

  def commit(c)
    render :partial => 'commit', :object => c
  end

  def blob_link(r,branch,prefix,name)
    link_to(name,"#{r.path}/#{branch}#{prefix}/#{name}")
  end

  def tree_link(r,branch,prefix,name)
    link_to("[D]" + name,"#{r.path}/#{branch}#{prefix}/#{name}")
  end
end
