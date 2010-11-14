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

  def blob_link(r,b)
    link_to(b.name,"#{r.path}/blob/master/#{b.name}")
  end

  def tree_link(r,branch,prefix,name)
    link_to("[D]" + name,"#{r.path}/tree/#{branch}#{prefix}/#{name}")
  end
end
