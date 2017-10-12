# Copyright
# ---------
#
# Copyright 2017 Bryan Wyatt, unless otherwise noted.
#
# This file is part of brwyatt-flatpak.
#
# brwyatt-flatpak is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# brwyatt-flatpak is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with brwyatt-flatpak.  If not, see <http://www.gnu.org/licenses/>.

Puppet::Type.type(:flatpak).provide(:flatpak) do

  commands :flatpak => '/usr/bin/flatpak'

  def create
    name = resource[:branch].nil? ? resource[:ref] : "#{resource[:ref]}//#{resource[:branch]}"
    args = [ "install", "--assumeyes", resource[:remote], name ]
    flatpak(args)
  end

  def destroy
    flatpak "uninstall", resource[:ref]
  end

  def exists?
    r = execute(["#{command(:flatpak)} info #{resource[:ref]}"], :failonfail => false)
    if r.exitstatus == 0
      true
    else
      false
    end
  end

end

# vim: ts=2 sts=2 sw=2 expandtab
